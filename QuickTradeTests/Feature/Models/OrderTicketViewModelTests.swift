//
//  OrderTicketViewModelTests.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import XCTest
@testable import QuickTrade

class OrderTicketViewModelTests: XCTestCase {
    var orderTicketViewModel: OrderTicketViewModel?
    let rate = Decimal(string: "1687.234")!

    override func setUp() {
        orderTicketViewModel = OrderTicketViewModel()
    }

    override func tearDown() {
        orderTicketViewModel = nil
    }
    
    func testStartTimer() {
        orderTicketViewModel?.viewDidLoad()
        XCTAssertNotNil(orderTicketViewModel?.timer)
    }
    
    func testStopTimer() {
        orderTicketViewModel?.stopTimer()
        XCTAssertTrue(orderTicketViewModel?.timer == nil)
    }
    
    func testRateForUnits() {
        orderTicketViewModel?.selectedCurrency = Currency(delayedPrice: rate,
                                                          recentPrice: rate,
                                                          buy: rate,
                                                          sell: rate,
                                                          symbol: "$")
        let computedValue = orderTicketViewModel?.rate(for: "2")
        XCTAssertEqual(computedValue, "3,374.47")
        
        let computedValue2 = orderTicketViewModel?.rate(for: "25")
        XCTAssertEqual(computedValue2, "42,180.85")
    }
    
    func testUnitsForRate() {
        orderTicketViewModel?.selectedCurrency = Currency(delayedPrice: rate,
                                                          recentPrice: rate,
                                                          buy: rate,
                                                          sell: rate,
                                                          symbol: "$")
        
        let computedValue = orderTicketViewModel?.units(for: "1687.234")
        XCTAssertEqual(computedValue, "1")
        
        let computedValue2 = orderTicketViewModel?.units(for: "13497.872")
        XCTAssertEqual(computedValue2, "8")
    }
}
