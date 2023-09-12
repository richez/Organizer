//
//  ProjectContentCreatorViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ProjectContentCreatorViewRepresentation {
    var backgroundColor: UIColor = .background

    var saveButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 60,
        backgroundColor: .projectContentCreatorButtonBackground,
        highlightedBackgroundColor: .projectContentCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectContentCreatorButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectContentCreatorButtonBackground.withAlphaComponent(0.1),
        tintColor: .black,
        image: UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
