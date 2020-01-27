//
//  ServiceErrorTests.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import XCTest
@testable import QuickTrade

class ServiceErrorTests: XCTestCase {

    func testServiceGenericError() {
        let serviceError = ServiceError.general(messsage: LocalizedString.genericError.description)
        XCTAssertNotNil(serviceError)
        switch serviceError {
        case let .general(message):
            XCTAssertEqual(message, "Something went wrong. Please try again.")
        }
    }
    
    func testServiceIncorrectRequestError() {
        let serviceError = ServiceError.general(messsage: LocalizedString.incorrectRequest.description)
        XCTAssertNotNil(serviceError)
        switch serviceError {
        case let .general(message):
            XCTAssertEqual(message, "Please check your request and try again.")
        }
    }
    
    func testServiceJSONNotFoundError() {
           let serviceError = ServiceError.general(messsage: LocalizedString.jsonNotFound.description)
           XCTAssertNotNil(serviceError)
           switch serviceError {
           case let .general(message):
               XCTAssertEqual(message, "Unable to find mock json.")
           }
       }
}
