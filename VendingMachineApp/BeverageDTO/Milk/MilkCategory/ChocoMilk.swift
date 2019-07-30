//
//  ChocoMilk.swift
//  VendingMachine
//
//  Created by hw on 04/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

/// 수입원료에 대한 원산지 표기 추가
/// 카카오 함량 추가
class ChocoMilk: Milk{
    private let proportion: Double
    private (set) var fruitOrigin: String

    init(
            brand: String,
            quantity: Int,
            price: Int,
            name: String,
            date: Date,
            isLowFat: Bool = false,
            kakaoPercent: Double = 0.1,
            fruitOrigin: String = "가나",
            milkFarmCode: FarmCode? = nil,
            calorySet: CaloryElements,
            temperature: Double
        ){
        self.proportion = kakaoPercent
        self.fruitOrigin = fruitOrigin
        
        super.init(brand: brand, quantity: quantity, price: price, name: name, date: date, isLowFat: isLowFat, milkFarmCode: milkFarmCode, calorySet: calorySet, temp: temperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case proportion
        case fruitOrigin
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        proportion = try container.decode(Double.self, forKey: .proportion)
        fruitOrigin = try container.decode(String.self, forKey: .fruitOrigin)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
}
extension ChocoMilk: Fruitable {
    func displayFruitProportion() -> Double {
        return self.proportion
    }
}
