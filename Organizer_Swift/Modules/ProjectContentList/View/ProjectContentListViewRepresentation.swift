//
//  ProjectContentListViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

struct ProjectContentListViewRepresentation {
    var backgroundColor: UIColor = .background

    var tableViewBackgroundColor: UIColor = .clear
    var tableViewEdgeInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
    var tableViewseparatorStyle: UITableViewCell.SeparatorStyle = .none

    var cellHeight: CGFloat = 100

    var contentCreatorButtonViewRepresentation: FloatingActionButtonViewRepresentation = .init(
        size: 60,
        backgroundColor: .contentCreatorButtonBackground,
        highlightedBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.1),
        tintColor: .black,
        image: UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    )

    var swipeDeleteViewRepresentation: ContextualActionViewRepresentation = .init(
        style: .destructive,
        imageName: "trash",
        backgroundColor: .swipeDeleteActionBackground
    )

    var swipeEditViewRepresentation: ContextualActionViewRepresentation = .init(
        style: .normal,
        imageName: "square.and.pencil",
        backgroundColor: .swipeEditActionBackground
    )
}
