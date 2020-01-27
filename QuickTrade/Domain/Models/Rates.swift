//
//  Rates.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

/// Model for Currency object returned from 'exchangeRates' api
public struct Currency: Codable, Hashable {
    let delayedPrice, recentPrice, buy, sell: Decimal
    let symbol: String
    
    public enum CodingKeys: String, CodingKey {
        case delayedPrice = "15m"
        case recentPrice = "last"
        case buy, sell, symbol
    }
}

typealias Rates = [String: Currency]
