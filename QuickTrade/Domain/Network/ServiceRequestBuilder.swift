//
//  ServiceRequestBuilder.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

final class ServiceRequestBuilder {
    
    private static func url(for endpoint: QuickTradeEndpoint) -> URL? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.path = endpoint.path
        return components.url
    }
    
    internal static func urlRequest(for endpoint: QuickTradeEndpoint) -> URLRequest? {
        guard let url = url(for: endpoint) else { return nil }
        
        var urlRequester = URLRequest(url: url)
        urlRequester.httpMethod = endpoint.method
        return urlRequester
    }
}
