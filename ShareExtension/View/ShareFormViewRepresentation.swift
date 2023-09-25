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
        alignment: .center,
        spacing: 12,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    )

    var errorLabelHeight: CGFloat = 50
    var errorLabelTextColor: UIColor = .red
    var errorLabelFont: UIFont = .systemFont(ofSize: 15, weight: .semibold)
    var errorTextAlignment: NSTextAlignment = .center

    var projectLabelHeight: CGFloat = 30
    var projectLabelTextColor: UIColor = .contentFormLabel
    var projectLabelFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var projectButtonHeight: CGFloat = 30
    var projectButtonBackgroundColor: UIColor = .white
    var projectButtonTitleColor: UIColor = .placeholderText

    var projectTextFieldHeight: CGFloat = 30
    var projectTextFieldFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var projectTextFieldBorderStyle: UITextField.BorderStyle = .roundedRect
    var projectTextFieldRules: TextFieldRules = .init(
        autocapitalizationType: .sentences,
        clearButtonMode: .always
    )

    var activityIndicatorStyle: UIActivityIndicatorView.Style = .large
    var activityIndicatorColor: UIColor = .contentFormSaveButtonBackground
}
