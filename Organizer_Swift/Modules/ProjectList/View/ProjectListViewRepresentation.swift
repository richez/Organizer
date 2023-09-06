//
//  ProjectListViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

struct ProjectListViewRepresentation {
    var backgroundColor: UIColor = .primaryDark
    var tableViewBackgroundColor: UIColor = .clear
    var cellHeight: CGFloat = 100
    var projectCreatorButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 50,
        backgroundColor: .projectCreatorButtonBackground,
        highlightedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.1),
        tintColor: .black,
        image: UIImage(
            systemName: "square.and.pencil",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )
}
