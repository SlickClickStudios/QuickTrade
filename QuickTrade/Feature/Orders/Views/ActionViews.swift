//
//  ActionViews.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

public enum ActionViewMode {
    case primary,
    secondary
}

final class ActionViews: UIView {
    
    /// Outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    
    /// Properties
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var mode: ActionViewMode = .primary {
        didSet {
            titleLabel.textColor = mode == .primary ? DefaultColor().green : DefaultColor().link
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
    
    private func setupViews() {
        Bundle(for: ActionViews.self).loadNibNamed("ActionViews",
                                                   owner: self,
                                                   options: nil)
        add(containerView)
        
        containerView.backgroundColor = .black
        mainView.backgroundColor = DefaultColor().actionViewBackground
        
        titleLabel.text = ""
        
        mode = .primary
    }
    
    private func setStyle() {
        /// Setup fonts
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
