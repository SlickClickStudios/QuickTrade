//
//  TextInputView.swift
//  QuickTrade
//
//  Created by Sunil Karkera on 28/1/20.
//  Copyright © 2020 Sunil Karkera. All rights reserved.
//

import UIKit

public enum TextInputViewMode {
    case units,
    currency
}

protocol TextInputViewDelegate: AnyObject {
    func textInputViewDidUpdate(text: String, mode: TextInputViewMode)
}

final class TextInputView: UIView {
    /// Outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    /// Constants
    let unitEntryCap = 8
    let amountEntryCap = 15
    
    /// Properties
    weak var delegate: TextInputViewDelegate?
    var numberOfDigits: Int = 0
    
    public var hasEnteredText: Bool  {
        get {
            guard let text = textField.text else { return false }
            return text.isEmpty ? false : true
        }
    }
    
    public var mode: TextInputViewMode = .units {
        didSet {
            numberOfDigits = mode == .units ? unitEntryCap : amountEntryCap
            textField.keyboardType = mode == .units ? .numberPad : .decimalPad
        }
    }
    
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
    
    public func bind(text: String) {
        textField.text = text
    }
    
    public override func resignFirstResponder() -> Bool {
           return textField.resignFirstResponder()
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
        textField.backgroundColor = DefaultColor().inputBackground
        
        /// Setup textField
        textField.layer.cornerRadius = Dimension().inputViewRadius
        textField.layer.masksToBounds = false
        textField.textAlignment = .center
        textField.delegate = self
    }
}

extension TextInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isInputFocused = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let textRange = Range(range, in: text)
            else { return false }
        
        let finalString = text.replacingCharacters(in: textRange, with: string)
        
        guard finalString.count <= numberOfDigits else { return false }
        
        /// Ask delegate to update relative TextInputViews
        delegate?.textInputViewDidUpdate(text: finalString, mode: mode)
        
        return true
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
