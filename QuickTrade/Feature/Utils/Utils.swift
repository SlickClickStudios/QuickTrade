//
//  Utils.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

public class Utils {
    static let currencyFormatter: NumberFormatter = {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.minimumFractionDigits = 2
        numberFormater.maximumFractionDigits = 2
        numberFormater.generatesDecimalNumbers = true
        return numberFormater
    }()
    
    static func formattedCurrency(for rate: Decimal) -> String? {
        let amount = NSDecimalNumber(decimal: rate)
        return currencyFormatter.string(from: amount)
    }
}
