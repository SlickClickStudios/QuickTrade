//
//  Result.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

/// Result type.
public enum Result<T> {
    /// Success.
    case success(T)

    /// Failure.
    case failure(Error)
}
