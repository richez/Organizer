//
//  ShareFormViewRepresentation.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

struct ShareFormViewRepresentation {
    var stackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .leading,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    )

    var contentsHeight: CGFloat = 30

    var errorLabelTextColor: UIColor = .red
    var errorLabelFont: UIFont = .systemFont(ofSize: 15, weight: .semibold)
    var errorTextAlignment: NSTextAlignment = .center

    var projectLabelTextColor: UIColor = .contentFormLabel
    var projectLabelFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var projectButtonBackgroundColor: UIColor = .white
    var projectButtonTitleColor: UIColor = .placeholderText

    var projectTextFieldFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var projectTextFieldBorderStyle: UITextField.BorderStyle = .roundedRect
    var projectTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .words,
        clearButtonMode: .always,
        autocorrectionType: .no,
        spellCheckingType: .no
    )
}
