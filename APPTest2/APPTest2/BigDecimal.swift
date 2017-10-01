//
//  BigDecimal.swift
//  Budgetable
//
//  Created by Tengzhe Li on 2/10/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
// Swift
// BigDecimal Library
class BigDecimal {
    var value: Int
    
    init(value: Int){
        self.value = value
    }
}

func + (left: BigDecimal, right: BigDecimal) -> BigDecimal {
    return BigDecimal(value : left.value + right.value)
}

func - (left: BigDecimal, right: BigDecimal) -> BigDecimal {
    return BigDecimal(value : left.value - right.value)
}

func * (left: BigDecimal, right: BigDecimal) -> BigDecimal {
    return BigDecimal(value : left.value * right.value)
}
