//
//  QuickTradeEndpoint.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

public enum QuickTradeEndpoint {
    case latestCurrencyRates
    
    var path: String {
        switch self {
        case .latestCurrencyRates:
            return "blockchain.info/ticker"
        }
    }
    
    var scheme: String {
        switch self {
        case .latestCurrencyRates:
            return "https"
        }
    }
    
    var method: String {
        switch self {
        case .latestCurrencyRates:
            return "GET"
        }
    }
}
