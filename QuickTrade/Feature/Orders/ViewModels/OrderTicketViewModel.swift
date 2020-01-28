//
//  OrderTicketViewModel.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

protocol OrderTicketViewProtocol {
    func viewDidLoad()
    func viewDidAppear()
    func rate(for unit: String) -> String
    func units(for rate: String) -> String
    func stopTimer()
}

protocol OrderTicketViewDelegate: AnyObject {
    func updatePanel(for mode: PanelMode, model: PricePanelViewModel)
    func updateAmountInputViews(with symbol: String)
}

class OrderTicketViewModel {
    
    /// Properties
    weak var delegate: OrderTicketViewDelegate?
    let orderService = OrderService()
    var selectedCurrency: Currency?
    var timer = Timer()
    
    /// Constants
    let selectedCurrencyCode = "GBP"
    let exchangeRatesPollingFrequency = 15
    
    // MARK: - Public routines
    
    init() { }
    
    // MARK: - Private routines
    
    private func startTimer() {
        /// Start timer for Polling 'exchangeRates' every 15 secs
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(exchangeRatesPollingFrequency),
                                     target: self,
                                     selector: #selector(fetchExchangeRates),
                                     userInfo: nil, repeats: true)
    }
    
    private func updateOrderTicketForm() {
        guard let selectedCurrency = selectedCurrency else { return }
        
        /// Update price panels
        let buyPricePanelViewModel = PricePanelViewModel(mode: .buy, currency: selectedCurrency)
        let sellPricePanelViewModel = PricePanelViewModel(mode: .sell, currency: selectedCurrency)
        
        delegate?.updatePanel(for: .buy, model: buyPricePanelViewModel)
        delegate?.updatePanel(for: .sell, model: sellPricePanelViewModel)
        
        /// Update Amount input views
        delegate?.updateAmountInputViews(with: selectedCurrency.symbol)
    }
    
    private func pricePanelViewModel(mode: PanelMode) -> PricePanelViewModel? {
        guard let selectedCurrency = selectedCurrency else { return nil }
        
        return PricePanelViewModel(mode: mode, currency: selectedCurrency)
    }
    
    @objc
    private func fetchExchangeRates() {
        orderService.exchangeRates(model: Rates.self) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(ratesData):
                
                /// Get currency data for 'GBP'
                let currencyData = ratesData.filter { $0.key == self.selectedCurrencyCode }.first
                if let currencyData = currencyData {
                    
                    /// Get currency from currencyData
                    let currency = currencyData.value
                    self.selectedCurrency = currency
                    
                    /// Update OrderTicketForm with selected currency
                    self.updateOrderTicketForm()
                }
                
            case .failure(_):
                /// Don't do anything
                break
                
            }
        }
    }
}

extension OrderTicketViewModel: OrderTicketViewProtocol {
    func viewDidLoad() {
        /// Starts timer for polling exchange rates
        startTimer()
    }
    
    func viewDidAppear() {
        /// Call exchange rates service
        fetchExchangeRates()
    }
    
    func rate(for unit: String) -> String {
        if let numberOfUnits = Double(unit),
            let buyPrice = selectedCurrency?.buy {
            
            /// Calculate amount from number of units entered by User
            let amount = numberOfUnits * (buyPrice as NSDecimalNumber).doubleValue
            
            /// Get decimal equivalent of amount and format into string
            return  Utils.formattedCurrency(for: Decimal(amount)) ?? ""
        }
        
        return ""
    }
    
    func units(for rate: String) -> String {
        if let currencyRate = Double(rate),
            let buyPrice = selectedCurrency?.buy {
            
            /// Calculate Units  from amount entered by User
            let units = currencyRate / (buyPrice as NSDecimalNumber).doubleValue
            
            return String(format: "%d", Int(units))
        }
        
        return ""
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}
