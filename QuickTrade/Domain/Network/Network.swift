//
//  Network.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

// MARK: - Types

/// Type for dictionary.
typealias JSON = [String: Any]

/// Service result.
typealias ServiceResult = Result<JSON>

/// Service callback.
typealias ServiceCallback = (ServiceResult) -> Void

/// Base service class
///
/// Implements common functionality for all service classess.
final class Network {
    static func submitRequest(with urlRequest: URLRequest, completion: @escaping ServiceCallback) {
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    do {
                        if let resultData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                            DispatchQueue.main.async {
                                completion(.success(resultData))
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }.resume()
    }
}
