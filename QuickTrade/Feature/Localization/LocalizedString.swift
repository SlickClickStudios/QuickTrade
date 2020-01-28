//
//  LocalizedString.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

enum LocalizedString: CustomStringConvertible {
    /// UI
    case cancelTitle
    case confirmTitle
    case stopLossTitle
    case takeProfitTitle
    case unitsTitle
    case amountTitle
    case amountCurrencyTitle(String)
    
    /// Network Service errors
    case genericError
    case incorrectRequest
    
    /// Mock testing  errors
    case jsonNotFound
    
    var description: String {
        switch self {
        /// UI
        case .cancelTitle:
            return localizeString("cancelTitle", comment: "Cancel title")
        case .confirmTitle:
            return localizeString("confirmTitle", comment: "Confirm title")
        case .stopLossTitle:
             return localizeString("stopLossTitle", comment: "Stop Loss title")
        case .takeProfitTitle:
             return localizeString("takeProfitTitle", comment: "Take Profit title")
        case .unitsTitle:
            return localizeString("unitsTitle", comment: "Units title")
        case .amountTitle:
            return localizeString("amountTitle", comment: "Amount title")
        case let .amountCurrencyTitle(text):
            return localizeString("amountCurrencyTitle", comment: "Amount title with currency", text)
            
        /// Network Service errors
        case .genericError:
            return localizeString("genericErrorMessage", comment: "Network service default error message")
        case .incorrectRequest:
            return localizeString("incorrectRequestErrorMessage", comment: "Error message for incorrect network service request")
            
        /// Mock testing  errors
        case .jsonNotFound:
            return localizeString("jsonNotFoundMessage", comment: "Unable to find mock testing json")
        }
    }
}

extension LocalizedString {
    private func localizeString(_ key: String, comment: String, _ arguments: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: nil, bundle: Bundle(for: BundleIdentifierClass.self), comment: comment)
        return String(format: format, locale: Locale.current, arguments: arguments)
    }
}

private final class BundleIdentifierClass {}
