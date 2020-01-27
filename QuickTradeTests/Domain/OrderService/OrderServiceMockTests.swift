//
//  OrderServiceMockTests.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import XCTest
@testable import QuickTrade

class OrderServiceMockTests: XCTestCase {
    /// Properties
    var mockOrderService: MockOrderService?
    
    override func setUp() {
        mockOrderService = MockOrderService()
    }
    
    override func tearDown() {
        mockOrderService = nil
    }
    
    /// Test 'exchangeRates' service using mock response
    func testOrderServiceMock_success() {
        let expectation = self.expectation(description: "Get latest Exchange rates successfully")
        
        /// Set stubs variable to 'tickerSuccess'
        mockOrderService?.stubs = .tickerSuccess
        
        mockOrderService?.exchangeRates(result: Rates.self, completion: { result in
            
            /// Validate result object
            switch result {
                
            case let .success(tickerData):
                XCTAssertNotNil(tickerData)
                
                /// Validate response data
                if let currencyData = tickerData.first {
                    XCTAssertNotNil(currencyData.key)
                    XCTAssertNotNil(currencyData.value)
                    
                    let currency = currencyData.value
                    XCTAssertNotNil(currency.buy)
                    XCTAssertNotNil(currency.sell)
                    XCTAssertNotNil(currency.delayedPrice)
                    XCTAssertNotNil(currency.recentPrice)
                    XCTAssertNotNil(currency.symbol)
                }
                
                expectation.fulfill()
                
            case .failure(_):
                break
            }
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Test 'exchangeRates' service using mock response for 'Malformed json' error scenario
    func testOrderServiceMock_error() {
        let expectation = self.expectation(description: "Get malformed JSON error")
        
        /// Set stubs variable to 'tickerMalformed'
        mockOrderService?.stubs = .tickerMalformed
        
        /// Validate result object
        mockOrderService?.exchangeRates(result: Rates.self, completion: { result in
            
            switch result {
                
            case .success(_):
                break
                
            case let .failure(error):
                /// Validate error returned from service
                XCTAssertNotNil(error)
                if let serviceError = error as? ServiceError {
                    switch serviceError {
                    case .general(let messsage):
                        XCTAssertEqual(messsage, "Something went wrong. Please try again.")
                    }
                }
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
