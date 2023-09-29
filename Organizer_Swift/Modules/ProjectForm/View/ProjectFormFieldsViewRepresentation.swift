//
//  ProjectFormFieldsViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

struct ProjectFormFieldsViewRepresentation {
    var stackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .leading,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    )

    var contentsHeight: CGFloat = 30

    var labelsTextColor: UIColor = .projectFormLabel
    var labelsFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var textFieldsFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var textFieldsBorderStyle: UITextField.BorderStyle = .roundedRect

    var nameTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .words,
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
