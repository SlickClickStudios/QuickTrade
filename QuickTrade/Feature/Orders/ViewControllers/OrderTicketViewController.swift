//
//  OrderTicketViewController.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

class OrderTicketViewController: UIViewController {
    /// Outlets
    @IBOutlet private var scrollView: UIScrollView!
    
    @IBOutlet private var sellPricePanelView: PricePanelView!
    @IBOutlet private var buyPricePanelView: PricePanelView!
    
    @IBOutlet private var unitsInputView: TextInputView!
    @IBOutlet private var amountInputView: TextInputView!
    
    @IBOutlet private weak var stopLossActionView: ActionViews!
    @IBOutlet private weak var takeProfitActionView: ActionViews!
    
    @IBOutlet private var cancelButton: PrimaryButton!
    @IBOutlet private var confirmButton: PrimaryButton!
    
    /// Propertires
    var orderTicketViewModel: OrderTicketViewModel?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setup delegates
        orderTicketViewModel?.delegate = self
        setupView()
        orderTicketViewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        orderTicketViewModel?.viewDidAppear()
    }
    
    deinit {
        orderTicketViewModel?.stopTimer()
        orderTicketViewModel = nil
    }
    
    // MARK:- Private routines
    
    func setupView() {
        /// Update price panels
        sellPricePanelView.mode = .sell
        buyPricePanelView.mode = .buy
        
        /// Update textInputViews
        unitsInputView.delegate = self
        unitsInputView.mode = .units
        unitsInputView.title = LocalizedString.unitsTitle.description
        
        amountInputView.delegate = self
        amountInputView.mode = .currency
        amountInputView.title = LocalizedString.amountTitle.description
        
        /// Update actionViews
        stopLossActionView.title = LocalizedString.stopLossTitle.description
        stopLossActionView.mode = .secondary
        
        takeProfitActionView.title = LocalizedString.takeProfitTitle.description
        takeProfitActionView.mode = .primary
        
        /// Update action buttons
        cancelButton.setTitle(LocalizedString.cancelTitle.description, for: .normal)
        confirmButton.setTitle(LocalizedString.confirmTitle.description, for: .normal)
        
        cancelButton.buttonStyleMode = .secondary
        confirmButton.buttonStyleMode = .primary
        confirmButton.isEnabled = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapView))
        self.scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        self.tapGestureRecognizer = tapGestureRecognizer
    }
    
    @objc public func didTapView(_ selector: UITapGestureRecognizer) {
        [unitsInputView, amountInputView].forEach { _ = $0?.resignFirstResponder() }
        
        confirmButton.isEnabled = unitsInputView.hasEnteredText && amountInputView.hasEnteredText
    }
}

extension OrderTicketViewController {
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        let alert = UIAlertController(
            title: LocalizedString.comingSoonAlertTitle.description,
            message: LocalizedString.featureAvailiabilityAlertMessage.description,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: false, completion: nil)
    }
}

extension OrderTicketViewController: OrderTicketViewDelegate {
    func updatePanel(for mode: PanelMode, model: PricePanelViewModel) {
        switch mode {
        case .buy:
            buyPricePanelView.bind(datasource: model)
        case .sell:
            sellPricePanelView.bind(datasource: model)
        }
    }
    
    func updateAmountInputViews(with symbol: String) {
        amountInputView.title = LocalizedString.amountCurrencyTitle(symbol).description
    }
}

extension OrderTicketViewController: TextInputViewDelegate {
    func textInputViewDidUpdate(text: String, mode: TextInputViewMode) {
        
        guard let orderTicketViewModel = orderTicketViewModel else { return }
        
        switch mode {
        case .units:
            let ratesString = orderTicketViewModel.rate(for: text)
            amountInputView.bind(text: ratesString)
            
        case .currency:
            let unitsString = orderTicketViewModel.units(for: text)
            unitsInputView.bind(text: unitsString)
        }
    }
}
