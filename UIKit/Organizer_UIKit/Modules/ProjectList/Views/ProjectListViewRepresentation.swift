//
//  ProjectListViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

/// Define the properties used to setup the ``ProjectListView``
struct ProjectListViewRepresentation {
    var backgroundColor: UIColor = .background

    var tableViewBackgroundColor: UIColor = .clear
    var tableViewEdgeInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
    var tableViewseparatorStyle: UITableViewCell.SeparatorStyle = .none

    var cellHeight: CGFloat = 110

    var createButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 60,
        backgroundColor: .projectCreatorButtonBackground,
        highlightedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .projectCreatorButtonBackground.withAlphaComponent(0.1),
        tintColor: .black
    )

    func createButtonImage(named name: String) -> UIImage? {
        UIImage(
            systemName: name,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    }

    func swipeActionStyle(for action: ProjectListSwipeAction) -> UIContextualAction.Style {
        switch action {
        case .delete:
            return .destructive
        case .edit:
            return .normal
        }
    }

    func swipeActionBackgroundColor(for action: ProjectListSwipeAction) -> UIColor {
        switch action {
        case .delete:
            return .swipeDeleteActionBackground
        case .edit:
            return .swipeEditActionBackground
        }
    }

    func contextMenuActionImage(imageName: String?) -> UIImage? {
        guard let imageName else { return nil }
        return UIImage(systemName: imageName)
    }

    func contextMenuActionAttributes(for action: ProjectListContextMenuAction) -> UIMenuElement.Attributes {
        switch action {
        case .duplicate, .edit:
            return []
        case .delete:
            return .destructive
        }
    }
}
