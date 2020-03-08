//
//  BeverageFacory.swift
//  VendingMachineApp
//
//  Created by 신한섭 on 2020/03/07.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class BeverageFactory {
    func makeBeverage(number: VendingMachine.BeverageNumbers) -> Beverage {
        switch number {
        case .ChocolateMilk:
            return ChocolateMilk(brand: "SeoulMilk",
                                 capacity: 300,
                                 price: .Cheap,
                                 name: "ChocolateMilk",
                                 manufacturingDate: Date(),
                                 calorie: .Middle,
                                 temperature: .Cool,
                                 beverageIndex: .ChocolateMilk,
                                 farmCode: Milk.FarmCode(index: Int.random(in: 0..<Milk.FarmCode.allCases.count)),
                                 package: .paper)
        case .StrawberryMilk:
            return StrawberryMilk(brand: "SeoulMilk",
                                  capacity: 300,
                                  price: .Cheap,
                                  name: "StrawberryMilk",
                                  manufacturingDate: Date(),
                                  calorie: .Middle,
                                  farmCode: Milk.FarmCode(index: Int.random(in: 0..<Milk.FarmCode.allCases.count)),
                                  temperature: .Cool,
                                  beverageIndex: .StrawberryMilk,
                                  juiceContent: 2)
        case .Coke:
            return Coke(brand: "CocaCola",
                        capacity: 355,
                        price: .Expensive,
                        name: "Coke",
                        manufacturingDate: Date(),
                        calorie: .High,
                        temperature: .Cool,
                        beverageIndex: .Coke,
                        carbonicAcid: 20)
            
        case .Cider:
            return Cider(brand: "CocaCola",
                         capacity: 355,
                         price: .Expensive,
                         name: "Cider",
                         manufacturingDate: Date(),
                         calorie: .High,
                         temperature: .Cool,
                         beverageIndex: .Cider,
                         taste: Cider.Taste(index: Int.random(in: 0..<Cider.Taste.allCases.count)))
            
        case .Georgia:
            return Georgia(brand: "CocaCola",
                           capacity: 240,
                           price: .Cheap,
                           name: "GeorGia",
                           manufacturingDate: Date(),
                           calorie: .Low,
                           temperature: .Hot,
                           beverageIndex: .Georgia,
                           decaffeinated: false,
                           black: false)
            
        case .TOP:
            return TOP(brand: "Maxim",
                       capacity: 275,
                       price: .Expensive,
                       name: "TOP",
                       manufacturingDate: Date(),
                       calorie: .Low,
                       temperature: .Hot,
                       beverageIndex: .TOP,
                       decaffeinated: false,
                       beanOrigin: TOP.BeanOrigin.init(index: Int.random(in: 0..<TOP.BeanOrigin.allCases.count)))
        }
    }
}