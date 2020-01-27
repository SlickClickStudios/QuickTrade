//
//  ServiceError.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

/// Service Error Types.
enum ServiceError: Error {
    /// General error with message.
    case general(messsage: String)
}
