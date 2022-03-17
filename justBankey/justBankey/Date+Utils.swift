//
//  Date+Utils.swift
//  justBankey
//
//  Created by  Mr.Ki on 15.03.2022.
//

import Foundation

extension Date {
    static var bankeydateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    var monthDayYearString: String {
        let dateFormatter = Date.bankeydateFormatter
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)

    }
}
