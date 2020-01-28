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
    @IBOutlet private var sellPricePanelView: PricePanelView!
    @IBOutlet private var buyPricePanelView: PricePanelView!
    
    @IBOutlet private var unitsInputView: TextInputView!
    @IBOutlet private var amountInputView: TextInputView!
    
    @IBOutlet weak var stopLossActionView: ActionViews!
    @IBOutlet weak var takeProfitActionView: ActionViews!
    
    @IBOutlet private var cancelButton: PrimaryButton!
    @IBOutlet private var confirmButton: PrimaryButton!
    
    /// Propertires
    var orderTicketViewModel: OrderTicketViewModel?
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        orderTicketViewModel?.viewDidLoad()
    }
    
    // MARK:- Private routines
    
    func setupView() {
        /// Update price panels
        sellPricePanelView.mode = .sell
        buyPricePanelView.mode = .buy
        
        /// Update textInputViews
        unitsInputView.title = LocalizedString.unitsTitle.description
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
    }
}
