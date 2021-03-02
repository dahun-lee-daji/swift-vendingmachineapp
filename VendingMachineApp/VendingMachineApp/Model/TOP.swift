//
//  TOP.swift
//  VendingMachineApp
//
//  Created by 이다훈 on 2021/02/24.
//

import Foundation

class TOP: Coffee {
    
    private let hot : Bool
    
    init(brand : String, volume : Int, charge : Int, name :String, manufacturing : Date, caffeine : Double?, hot : Bool) {
        self.hot = hot
        super.init(brand: brand, volume: volume, charge: charge, name: name, manufacturing: manufacturing, caffeine: caffeine)
    }
    
    convenience init() {
        self.init(brand: "Maxim", volume: 275, charge: 980, name: "TOP 스위트 아메리카노", manufacturing: Date.init(), caffeine : 123.45, hot: true)
    }
    
    func isHot() -> Bool {
        return hot
    }
}