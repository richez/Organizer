//
//  UITextField+Rules.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 13/09/2023.
//

import UIKit

struct TextFieldRules {
    var autocapitalizationType: UITextAutocapitalizationType = .sentences
    var clearButtonMode: UITextField.ViewMode = .never
    var keyboardType: UIKeyboardType = .default
    var autocorrectionType: UITextAutocorrectionType = .default
    var inlinePredictionType: UITextInlinePredictionType = .default
    var spellCheckingType: UITextSpellCheckingType = .default
}

extension UITextField {
    func apply(rules: TextFieldRules) {
        self.autocapitalizationType = rules.autocapitalizationType
        self.clearButtonMode = rules.clearButtonMode
        self.keyboardType = rules.keyboardType
        self.autocorrectionType = rules.autocorrectionType
        self.inlinePredictionType = rules.inlinePredictionType
        self.spellCheckingType = rules.spellCheckingType
    }
}
