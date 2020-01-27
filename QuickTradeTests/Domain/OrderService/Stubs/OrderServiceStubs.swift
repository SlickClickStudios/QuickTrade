//
//  OrderServiceStubs.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

/// Enums depicting JSON stub file names used for mock testing
enum OrderServiceStubs: String {
    case none
    case tickerSuccess
    case tickerMalformed

    /// Return path of JSON files used for mock testing
    var path: String? {
        return Bundle(for: MockOrderService.self).path(forResource: rawValue, ofType: "json")
    }
}
