//
//  PricePanelViewModel.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

final class PricePanelViewModel {
    /// Properties
    let panelMode: PanelMode
    let currency: Currency
    
    // MARK: - Init
    init(mode: PanelMode, currency: Currency) {
        self.panelMode = mode
        self.currency = currency
    }
}

extension PricePanelViewModel: PricePanelViewDataSource {
    var title: String {
        return panelMode == .buy ? LocalizedString.buyTitle.description : LocalizedString.sellTitle.description
    }
    
    var price: String {
        let price = panelMode == .buy ? currency.buy : currency.sell
        return Utils.formattedCurrency(for: price) ?? ""
    }
    
    var historicalPrice: String {
        let formatter = panelMode == .buy ? "H: %@" : "L: %@"
        
        let currencyString = Utils.formattedCurrency(for: currency.recentPrice) ?? ""
        
        return String(format: formatter, currencyString)
    }
    
    var mode: PanelMode {
        return panelMode
    }
}
