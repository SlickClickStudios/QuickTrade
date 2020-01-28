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

public protocol PricePanelViewDataSource {
    var title: String { get }
    var price: String { get }
    var historicalPrice: String { get }
    var mode: PanelMode { get }
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
    
    public func bind(datasource: PricePanelViewDataSource) {
        titleLabel.text = datasource.title
        
        historicalPriceLabel.text = datasource.historicalPrice
        
        mode = datasource.mode
        
        animate(price: formattedPrice(for: datasource.price))
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
    
    private func formattedPrice(for text: String) -> NSAttributedString {
        let font = UIFont.preferredFont(forTextStyle: .title1)
        let subscriptFont = UIFont.preferredFont(forTextStyle: .title3)
        let location = text.count - 2
        
        let mutablePriceString = NSMutableAttributedString(string: text, attributes: [.font: font])
        mutablePriceString.setAttributes([.font: subscriptFont, .baselineOffset: 0],
                                         range: NSRange(location: location, length: 2))
        return mutablePriceString
    }
    
    private func animate(price: NSAttributedString) {
        priceLabel.alpha = 0.0;
        priceLabel.attributedText = price
        
        UIView.animate(withDuration: 0.3,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse],
            animations: {  self.priceLabel.alpha = 1.0 },
            completion: { ( status) in
                self.priceLabel.alpha = 0.5
                self.priceLabel.textColor = DefaultColor().lightGreen
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.priceLabel.textColor = DefaultColor().green
            self.priceLabel.alpha = 1.0
            self.priceLabel.attributedText = price
        }
    }
}
