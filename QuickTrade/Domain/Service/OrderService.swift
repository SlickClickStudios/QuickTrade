//
//  OrderService.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

class OrderService {
    /**
     Makes Network request and decodes returned JSON data into models.
     
     - Parameters:
     - endpoint: The network endpoint for the request
     - result: The response model for given request  endpoint
     - completion: Completion block with Result type (success or failure)
     
     */
    func request<T>(for endpoint: QuickTradeEndpoint,
                    model: T.Type,
                    completion: @escaping (Result<T>) -> Void) where T: Codable {
        
        /// Get urlRequest object for given endpoint
        guard let urlRequest = ServiceRequestBuilder.urlRequest(for: endpoint) else {
            let serviceError = ServiceError.general(messsage: LocalizedString.incorrectRequest.description)
            return completion(.failure(serviceError))
        }
        
        /// Make network call
        Network.submitRequest(with: urlRequest) { result in
            switch result {
            case let .success(jsonData):
                do {
                    /// Decode JSON object into models
                    let responseModel = try JSONDecoder().decode(T.self, jsonObject: jsonData)
                    completion(.success(responseModel))
                } catch  {
                    /// Decoding failed,  return error
                    let genericError = ServiceError.general(messsage: LocalizedString.genericError.description)
                    completion(.failure(genericError))
                }
                
            case let .failure(error):
                /// Network request failure encountered, return error
                completion(.failure(error))
            }
        }
        
    }
}

extension OrderService: OrderServiceProvider {
    func exchangeRates<T>(model: T.Type,
                          completion: @escaping (Result<T>) -> Void) where T: Codable {
        
        /// Get latest exchange rates
        request(for: .latestCurrencyRates, model: model, completion: completion)
    }
}
