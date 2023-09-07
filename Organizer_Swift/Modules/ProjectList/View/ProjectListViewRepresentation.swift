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
    var tableViewEdgeInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
    var cellHeight: CGFloat = 100
    var projectCreatorButtonViewRepresentation: FloatingActionButtonViewRepresentation = .init(
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
