//
//  ProjectCreatorViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

struct StackViewRepresentation {
    var axis: NSLayoutConstraint.Axis
    var distribution: UIStackView.Distribution
    var alignment: UIStackView.Alignment
    var spacing: CGFloat
    var layoutMargins: UIEdgeInsets?
}

extension UIStackView {
    func setup(with viewRepresentation: StackViewRepresentation) {
        self.axis = viewRepresentation.axis
        self.distribution = viewRepresentation.distribution
        self.alignment = viewRepresentation.alignment
        self.spacing = viewRepresentation.spacing

        if let layoutMargins = viewRepresentation.layoutMargins {
            self.layoutMargins = layoutMargins
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
}

struct ProjectCreatorViewRepresentation {
    var backgroundColor: UIColor = .primaryDark
    var stackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .center,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    )

    var labelsHeight: CGFloat = 30
    var labelsTextColor: UIColor = .primaryLight
    var labelsFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var textFieldsHeight: CGFloat = 30
    var textFieldsFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    var textFieldsBorderStyle: UITextField.BorderStyle = .roundedRect

    var saveButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 50,
        backgroundColor: .projectCreatorButtonBackground,
        highlightedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        tintColor: .black,
        image: UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
