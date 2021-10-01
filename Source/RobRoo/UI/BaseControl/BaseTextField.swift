//
//  TextField.swift
//
//
//  Created by Apple on 6/21/17.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0

class BaseTextField: UITextField {
    @IBInspectable var placeholderText: String = "" {
        didSet {
            self.placeholder = placeholderText.localized
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = .gray {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
                                                       attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    @IBInspectable var padding: CGFloat = 0.0 {
        didSet {
            if padding > 0 {
                let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: frame.size.height))
                leftView = paddingView
                leftViewMode = .always
            }
        }
    }
    
    var handleText: ((String) -> Void)?
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        handleText?(text ?? "")
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText[..<maxCharIndex])
        selectedTextRange = selection
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
                                                   attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
        self.autocorrectionType = .no
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
                                                   attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
        self.autocorrectionType = .no
        layoutIfNeeded()
    }
}
