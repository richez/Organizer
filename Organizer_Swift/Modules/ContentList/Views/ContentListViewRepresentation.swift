//
//  ContentListViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

/// Define the properties used to setup the ``ContentListView``
struct ContentListViewRepresentation {
    var backgroundColor: UIColor = .background

    var tableViewBackgroundColor: UIColor = .clear
    var tableViewEdgeInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
    var tableViewseparatorStyle: UITableViewCell.SeparatorStyle = .none

    var cellHeight: CGFloat = 100

    func createButtonViewRepresentation(imageName: String) -> FloatingActionButtonViewRepresentation {
        .init(
            size: 60,
            backgroundColor: .contentCreatorButtonBackground,
            highlightedBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.3),
            selectedBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.3),
            disabledBackgroundColor: .contentCreatorButtonBackground.withAlphaComponent(0.1),
            tintColor: .black,
            image: UIImage(
                systemName: imageName,
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        )
    }

    func swipeActionStyle(for action: ContentListSwipeAction) -> UIContextualAction.Style {
        switch action {
        case .delete:
            return .destructive
        case .edit:
            return .normal
        }
    }

    func swipeActionBackgroundColor(for action: ContentListSwipeAction) -> UIColor {
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

    func contextMenuActionAttributes(for action: ContentListContextMenuAction) -> UIMenuElement.Attributes {
        switch action {
        case .openBrowser, .copyLink, .edit:
            return []
        case .delete:
            return .destructive
        }
    }
}
