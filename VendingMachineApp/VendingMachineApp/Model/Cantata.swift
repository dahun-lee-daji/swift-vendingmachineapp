//
//  Cantata.swift
//  VendingMachineApp
//
//  Created by 이다훈 on 2021/02/24.
//

import Foundation

class Cantata: Coffee {
    
    private let bean : Beans
    
    init(brand : String, volume : Int, charge : Int, name :String, manufacturing : Date, caffeine : Double?, bean : Beans) {
        self.bean = bean
        super.init(brand: brand, volume: volume, charge: charge, name: name, manufacturing: manufacturing, caffeine: caffeine)
    }
    
    convenience init() {
        self.init(brand: "롯데칠성음료", volume: 430, charge: 1400, name: "칸타타 콘트라베이스", manufacturing: Date.init(), caffeine : nil, bean: .arabica)
    }
    
    func productBeans() -> Beans {
        return self.bean
    }
}