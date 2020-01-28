//
//  PrimaryButton.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

public enum ButtonStyleMode {
    case primary,
    secondary
}

final class PrimaryButton: UIButton {
    
    /// Constants
    private let offsetForButtonEnabled: CGFloat = 1.0
    private let offsetForButtonDisabled: CGFloat = 0.5
    
    public var buttonStyleMode: ButtonStyleMode = .primary {
        didSet {
            backgroundColor = buttonStyleMode == .primary ? DefaultColor().lightSeaBlue : DefaultColor().gray
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? offsetForButtonEnabled : offsetForButtonDisabled
            isUserInteractionEnabled = isEnabled
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
    
    // MARK: - Private routines
    
    private func setStyle() {
        /// Set button corner radius
        layer.cornerRadius = Dimension().inputViewRadius
        
        /// Set button mode
        buttonStyleMode = .primary
        
        /// Set button title
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        setTitleColor(.white, for: .normal)
    }
    
    private func setupViews() {
        guard let titleLabel = titleLabel else { return }
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
}
