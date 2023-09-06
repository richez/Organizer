//
//  ProjectCreatorViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

struct ProjectCreatorViewRepresentation {
    var backgroundColor: UIColor = .primaryDark
    var stackViewRepresentation: StackViewRepresentation = .init(
        axis: .vertical,
        distribution: .fill,
        alignment: .center,
        spacing: 8,
        layoutMargins: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
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
