//
//  OrderServiceProvider.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

public protocol OrderServiceProvider {
    /// Gets latest exchanges rates for a set of currencies
    func exchangeRates<T: Codable>(model: T.Type,
                                   completion: @escaping (Result<T>) -> Void)
}
