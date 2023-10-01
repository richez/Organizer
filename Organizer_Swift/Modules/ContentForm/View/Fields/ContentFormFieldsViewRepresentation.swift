//
//  ContentFormFieldsViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

/// Define the properties used to setup the ``ContentFormFieldsView``
struct ContentFormFieldsViewRepresentation {
    var formStackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .leading,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    )

    var linkStackViewRepresentation: StackViewRepresentation = .init(
        axis: .horizontal,
        distribution: .fillProportionally,
        alignment: .leading,
        spacing: 5,
        layoutMargins: .zero
    )

    var contentsHeight: CGFloat = 30

    var typeButtonBackgroundColor: UIColor = .white
    var typeButtonTitleColor: UIColor = .placeholderText

    var labelsTextColor: UIColor = .contentFormLabel
    var errorLabelsTextColor: UIColor = .red
    var labelsFont: UIFont = .systemFont(ofSize: 15, weight: .bold)
    var errorLabelsFont: UIFont = .systemFont(ofSize: 15, weight: .medium)

    var textFieldsFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var textFieldsBorderStyle: UITextField.BorderStyle = .roundedRect

    var nameGetterTitleColor: UIColor = .link
    var nameGetterDisabledTitleColor: UIColor = .link.withAlphaComponent(0.5)
    var nameGetterHighlightedTitleColor: UIColor = .link.withAlphaComponent(0.5)
    var nameGetterFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var linkTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .none,
        clearButtonMode: .always,
        keyboardType: .URL,
        autocorrectionType: .no,
        inlinePredictionType: .no,
        spellCheckingType: .no,
        returnKeyType: .next
    )

    var nameTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .sentences,
        clearButtonMode: .always,
        autocorrectionType: .no,
        spellCheckingType: .no,
        returnKeyType: .next
    )

    var themeTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .none,
        clearButtonMode: .always,
        autocorrectionType: .no,
        spellCheckingType: .no
    )
}
