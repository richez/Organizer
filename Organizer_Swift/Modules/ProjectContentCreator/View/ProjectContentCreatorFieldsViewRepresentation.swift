//
//  ProjectContentCreatorFieldsViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ProjectContentCreatorFieldsViewRepresentation {
    var stackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .center,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    )

    var typeButtonHeight: CGFloat = 30
    var typeButtonBackgroundColor: UIColor = .white
    var typeButtonTitleColor: UIColor = .placeholderText

    var labelsHeight: CGFloat = 30
    var labelsTextColor: UIColor = .projectContentCreatorLabel
    var labelsFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var textFieldsHeight: CGFloat = 30
    var textFieldsFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var textFieldsBorderStyle: UITextField.BorderStyle = .roundedRect

    var nameTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .sentences,
        clearButtonMode: .always
    )

    var themeTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .none,
        clearButtonMode: .always
    )

    var linkTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .none,
        clearButtonMode: .always,
        keyboardType: .URL,
        autocorrectionType: .no,
        inlinePredictionType: .no,
        spellCheckingType: .no
    )
}
