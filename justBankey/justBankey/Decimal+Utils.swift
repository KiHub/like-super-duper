//
//  DecimalUtils.swift
//  justBankey
//
//  Created by  Mr.Ki on 13.03.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
