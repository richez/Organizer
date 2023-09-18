//
//  ProjectContentFormViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ProjectContentFormViewRepresentation {
    var backgroundColor: UIColor = .background

    var saveButtonViewRepresentation: FloatingActionButtonViewRepresentation = .init(
        size: 60,
        backgroundColor: .projectContentFormSaveButtonBackground,
        highlightedBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.1),
        tintColor: .black,
        image: UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
