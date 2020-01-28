//
//  OrderServiceNetworkTests.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 27/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import XCTest
@testable import QuickTrade

class OrderServiceNetworkTests: XCTestCase {
    /// Properties
    var orderService: OrderService?
    
    override func setUp() {
        orderService = OrderService()
    }
    
    override func tearDown() {
        orderService = nil
    }
    
    /// Test 'exchangeRates' service for network request and successfull JSON parsing
    func testOrderService_success() {
        let expectation = self.expectation(description: "Get latest Exchange rates successfully")
        
        orderService?.exchangeRates(model: Rates.self, completion: { result in
            
            /// Validate result object
            switch result {
                
            case let .success(tickerData):
                XCTAssertNotNil(tickerData)
                
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
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    /// Test 'exchangeRates' service for network request with 'Malformed json' parsing error
    func testOrderService_jsonSerializationError() {
        let expectation = self.expectation(description: "Get malformed JSON error")
        
        orderService?.exchangeRates(model: Currency.self, completion: { result in
            
            /// Validate result object
            switch result {
                
            case .success(_):
                break
                
            case let .failure(error):
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
