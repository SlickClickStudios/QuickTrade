//
//  PricePanelView.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

public enum PanelMode: String {
    case buy = "BUY"
    case sell = "SELL"
}

public struct PricePanelViewModel {
    public let title: String
    public let price: String
    public let historicalPrice: String
    public let mode: PanelMode
    
    public init(title: String,
                price: String,
                historicalPrice: String,
                mode: PanelMode) {
        self.title = title
        self.price = price
        self.historicalPrice = historicalPrice
        self.mode = mode
    }
}

final class PricePanelView: UIView {
    
    /// Outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var historicalPriceLabel: UILabel!
    
    /// Properties
    public var mode: PanelMode = .buy {
        didSet {
            titleLabel.textAlignment = mode == .buy ? .right : .left
            titleLabel.text = mode.rawValue
            titleLabel.textColor = mode == .buy ? DefaultColor().seaBlue : DefaultColor().orange
            
            historicalPriceLabel.textAlignment = mode == .buy ? .right : .left
            containerView.backgroundColor = mode == .buy ? DefaultColor().panelLightBackground : DefaultColor().panelDarkBackground
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setStyle()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setStyle()
    }
    
    // MARK: - Public routine
    
    public func bind(datasource: PricePanelViewModel) {
        titleLabel.text = datasource.title
        priceLabel.text = datasource.price
        historicalPriceLabel.text = datasource.historicalPrice
        mode = datasource.mode
    }
    
    // MARK: - Private routines
    
    private func setupViews() {
        Bundle(for: PricePanelView.self).loadNibNamed("PricePanelView",
                                                      owner: self,
                                                      options: nil)
        add(containerView)
        
        containerView.backgroundColor = .clear
        
        [titleLabel, priceLabel, historicalPriceLabel].forEach {
            $0?.text = ""
        }
        
        priceLabel.text = "0.00"
    }
    
    private func setStyle() {
        /// Setup fonts
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        priceLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        historicalPriceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        /// Setup colors
        historicalPriceLabel.textColor = DefaultColor().muted
        priceLabel.textColor = DefaultColor().green
    }
}
