//
//  ProjectFormViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

/// Define the properties used to setup the ``ProjectFormView``
struct ProjectFormViewRepresentation {
    var backgroundColor: UIColor = .background

    var saveButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 60,
        backgroundColor: .projectFormSaveButtonBackground,
        highlightedBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.1),
        tintColor: .black
    )

    func saveButtonImage(named name: String) -> UIImage? {
        UIImage(
            systemName: name,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    }
}
