//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by moon on 2018. 6. 24..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class VendingMachine: NSObject, NSSecureCoding {
    
    private var moneyManager: MoneyManager
    private var stockManager: StockManager
    private static var sharedVendingMachine = VendingMachine()
    
    private init(_ moneyManager: MoneyManager, _ stockManager: StockManager) {
        self.moneyManager = moneyManager
        self.stockManager = stockManager
    }
    
    override init() {
        self.moneyManager = MoneyManager()
        self.stockManager = StockManager()
        super.init()
    }
    
    class func shared() -> VendingMachine {
        return self.sharedVendingMachine
    }
    
    func readAllStock() -> [Stock] {
        return self.stockManager.allStock
    }
    
    func readBalance() -> Int {
        return self.moneyManager.readBalance()
    }
    
    func insertMoney(_ price: Int) {
        self.moneyManager.increaseBalance(price)
    }
    
    func addBeverage(_ beverage: Beverage) {
        stockManager.addStock(beverage)
    }
    
    func addBeverage(_ beverage: Beverage, _ count: Int) {
        for _ in 0..<count {
            self.addBeverage(beverage)
        }
    }
    
    func readStock(_ index: Int) -> Int {
        guard let menu = Menu.init(rawValue: index) else {
            return 0
        }
        return self.stockManager.readStock(menu.beverageType)
    }
    
    // MARK: NSSecureCoding
    private struct NSCoderKeys {
        static let moneyManagerKey = "moneyManager"
        static let stockManagerKey = "stockManager"
    }
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let moneyManager = aDecoder.decodeObject(of: MoneyManager.self, forKey: NSCoderKeys.moneyManagerKey) else {
            return nil
        }
        guard let stockManager = aDecoder.decodeObject(of: StockManager.self, forKey: NSCoderKeys.stockManagerKey) else {
            return nil
        }
        self.moneyManager = moneyManager
        self.stockManager = stockManager
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(moneyManager, forKey: NSCoderKeys.moneyManagerKey)
        aCoder.encode(stockManager, forKey: NSCoderKeys.stockManagerKey)
    }
}