//
//  ProjectsViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

struct ProjectsViewRepresentation {
    var backgroundColor: UIColor = .primaryDark
    var tableViewBackgroundColor: UIColor = .clear
    var cellHeight: CGFloat = 100
    var newProjectButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 50,
        backgroundColor: .newProjectButtonBackground,
        highlightedBackgroundColor: .newProjectButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .newProjectButtonBackground.withAlphaComponent(0.3),
        tintColor: .black,
        image: UIImage(
            systemName: "square.and.pencil",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
