//
//  ProjectCreatorViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

struct ProjectCreatorViewRepresentation {
    var backgroundColor: UIColor = .background

    var saveButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 50,
        backgroundColor: .projectCreatorButtonBackground,
        highlightedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.1),
        tintColor: .black,
        image: UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
