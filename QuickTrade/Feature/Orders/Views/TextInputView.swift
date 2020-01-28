//
//  TextInputView.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

final class TextInputView: UIView {
    /// Outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    /// Properties
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var text: Decimal {
        get {
            return Decimal(string: textField.text ?? "0") ?? 0.0
        }
    }
    
    private var isInputFocused: Bool = false {
        didSet {
            textField.layer.borderColor = isInputFocused ? DefaultColor().lightSeaBlue.cgColor : UIColor.clear.cgColor
            textField.layer.borderWidth = Dimension().standardBorderWidth
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
        Bundle(for: TextInputView.self).loadNibNamed("TextInputView",
                                                     owner: self,
                                                     options: nil)
        add(containerView)
        
        containerView.backgroundColor = .black
        
        titleLabel.text = ""
        textField.text = ""
    }
    
    private func setStyle() {
        /// Setup fonts
        titleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        
        /// Setup colors
        titleLabel.textAlignment = .center
        titleLabel.textColor = DefaultColor().seaBlue
        textField.textColor = .white
        textField.backgroundColor = DefaultColor().darkGray
        
        /// Setup textField
        textField.layer.cornerRadius = Dimension().inputViewRadius
        textField.layer.masksToBounds = false
        textField.textAlignment = .center
        textField.keyboardType = .asciiCapableNumberPad
        textField.delegate = self
    }
}

extension TextInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isInputFocused = true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        isInputFocused = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isInputFocused = false
        self.resignFirstResponder()
    }
}
