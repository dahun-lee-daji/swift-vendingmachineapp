//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 조재흥 on 18. 12. 27..
//  Copyright © 2018 hngfu. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet var productImageViews: [UIImageView]!
    @IBOutlet var numberOfProductLabels: [UILabel]!
    
    //MARK: Private
    
    private var historyViewInterval: CGFloat = 0
    
    //MARK: - Methods
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateNumberOfProductLabel),
                                               name: .didChangeNumberOfProduct,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateBalanceLabel),
                                               name: .didChangeBalance,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addRecentHistoryImageView),
                                               name: .didChangeHistoryOfPurchase,
                                               object: nil)
        
        updateLabels()
        addOldHistoryImageViews()
    }
    
    //MARK: Private
    
    @objc private func updateNumberOfProductLabel(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo else { return }
        guard let numberOfProduct = userInfo[UserInfoKey.numberOfProduct] as? Int else { return }
        guard let labelToUpdate = userInfo[UserInfoKey.labelToUpdate] as? Int else { return }
        
        numberOfProductLabels[labelToUpdate - 1].text = "\(numberOfProduct)개"
    }
    
    @objc private func updateBalanceLabel(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo else { return }
        guard let balance = userInfo[UserInfoKey.balance] as? Money else { return }
        
        let updateBalanceLabel = { [unowned self] (balance: Int) -> Void in
            self.balanceLabel.text = "잔액 : \(balance)원"
        }
        balance.updateBalanceLabel(update: updateBalanceLabel)
    }
    
    @objc private func addRecentHistoryImageView(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo else { return }
        guard let product = userInfo[UserInfoKey.recentPurchaseProduct] as? Beverage else { return }
        addHistoryImageView(product)
    }
    
    private func updateLabels() {
        
        let updateBalanceLabel: (String) -> Void = { [unowned self] (balance: String) -> Void in
            self.balanceLabel.text = "잔액 : \(balance)원"
        }
        VendingMachine.sharedInstance.updateBalance(update: updateBalanceLabel)
        
        for numberOfProductLabel in numberOfProductLabels {
            let tag = numberOfProductLabel.tag
            guard let beverageType = Mapper.shared.mapping(by: tag) else { return }
            
            let updateNumberOfProductLabel: (Int) -> Void = { (numberOfProduct: Int) -> Void in
                numberOfProductLabel.text = "\(numberOfProduct)개"
            }
            VendingMachine.sharedInstance.updateNumber(of: beverageType, update: updateNumberOfProductLabel)
        }
    }
    
    private func addOldHistoryImageViews() {
        
        let addHistoryImageViews = { [unowned self] (historyOfPurchase: [Beverage]) -> Void in
            for beverage in historyOfPurchase {
                self.addHistoryImageView(beverage)
            }
        }
        VendingMachine.sharedInstance.perform(addHistoryImageViews)
    }
    
    private func addHistoryImageView(_ product: Beverage) {
        
        guard let imageName = Mapper.shared.imageMapping(by: type(of: product)) else { return }
        guard let productImage = UIImage(named: imageName) else { return }
        let productImageView = UIImageView(image: productImage)
        productImageView.frame = CGRect(x: 40 + self.historyViewInterval,
                                        y: 575,
                                        width: 140,
                                        height: 100)
        self.historyViewInterval += 50
        productImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(productImageView)
    }
    
    //MARK: IBAction
    
    @IBAction func tapInsertMoneyButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            VendingMachine.sharedInstance.insert(money: .thousand)
        case 2:
            VendingMachine.sharedInstance.insert(money: .fiveThousand)
        default:
            return
        }
    }
    
    @IBAction func tapBuyBeverageButton(_ sender: UIButton) {
        
        let tag = sender.tag
        guard let productType = Mapper.shared.mapping(by: tag) else { return }
        let _ = VendingMachine.sharedInstance.buy(productType: productType)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ManagerViewController" {
            let managerViewController = segue.destination as! ManagerViewController
            var stockLabelTexts: [String?] = []

            for index in self.numberOfProductLabels.startIndex..<self.numberOfProductLabels.endIndex {
                let customerLabelText = self.numberOfProductLabels[index].text
                stockLabelTexts.append(customerLabelText)
            }
            
            managerViewController.stockInfo = stockLabelTexts
        }
    }
}