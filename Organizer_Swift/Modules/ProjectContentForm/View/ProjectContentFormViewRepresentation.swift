//
//  ProjectContentFormViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ProjectContentFormViewRepresentation {
    var backgroundColor: UIColor = .background

    func saveButtonViewRepresentation(imageName: String) -> FloatingActionButtonViewRepresentation {
        .init(
            size: 60,
            backgroundColor: .projectContentFormSaveButtonBackground,
            highlightedBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.3),
            selectedBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.3),
            disabledBackgroundColor: .projectContentFormSaveButtonBackground.withAlphaComponent(0.1),
            tintColor: .black,
            image: UIImage(
                systemName: imageName,
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        )
    }
}
