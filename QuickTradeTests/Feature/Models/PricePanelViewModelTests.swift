//
//  PricePanelViewModelTests.swift
//  QuickTradeTests
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import XCTest
@testable import QuickTrade

class PricePanelViewModelTests: XCTestCase {
    var pricePanelViewModel: PricePanelViewModel?
    let buyRate = Decimal(string: "1687.234")!
    let sellRate = Decimal(string: "2820.12")!
    
    func testPricePanelViewBuyMode() {
        let currency = Currency(delayedPrice: buyRate,
                                recentPrice: buyRate,
                                buy: buyRate,
                                sell: buyRate,
                                symbol: "$")
        
        pricePanelViewModel = PricePanelViewModel(mode: .buy, currency: currency)
        XCTAssertEqual(pricePanelViewModel?.title, "BUY")
        XCTAssertEqual(pricePanelViewModel?.price, "1,687.23")
        XCTAssertEqual(pricePanelViewModel?.historicalPrice, "H: 1,687.23")
        XCTAssertEqual(pricePanelViewModel?.panelMode, .buy)
    }
    
    func testPricePanelViewSellMode() {
        let currency = Currency(delayedPrice: sellRate,
                                recentPrice: sellRate,
                                buy: sellRate,
                                sell: sellRate,
                                symbol: "$")
        
        pricePanelViewModel = PricePanelViewModel(mode: .sell, currency: currency)
        XCTAssertEqual(pricePanelViewModel?.title, "SELL")
        XCTAssertEqual(pricePanelViewModel?.price, "2,820.12")
        XCTAssertEqual(pricePanelViewModel?.historicalPrice, "L: 2,820.12")
        XCTAssertEqual(pricePanelViewModel?.panelMode, .sell)
    }
}
