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

    func saveButtonViewRepresentation(imageName: String) -> FloatingActionButtonViewRepresentation {
        .init(
            size: 60,
            backgroundColor: .projectFormSaveButtonBackground,
            highlightedBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.3),
            selectedBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.3),
            disabledBackgroundColor: .projectFormSaveButtonBackground.withAlphaComponent(0.1),
            tintColor: .black,
            image: UIImage(
                systemName: imageName,
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        )
    }
}
