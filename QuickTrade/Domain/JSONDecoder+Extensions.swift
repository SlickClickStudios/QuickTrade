//
//  JSONDecoder+Extensions.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, jsonObject: JSON) throws -> T where T: Decodable {
        keyDecodingStrategy = .convertFromSnakeCase
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
        return try decode(type, from: data)
    }
}
