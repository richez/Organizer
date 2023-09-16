//
//  ProjectContentListViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

enum ProjectContentListViewModelError: RenderableError {
    case fetch(Error)
    case delete(UUID)

    var title: String {
        switch self {
        case .fetch:
            return "Fail to fetch project contents"
        case .delete:
            return "Fail to delete project content"
        }
    }

    var message: String { "Please try again later" }

    var actionTitle: String { "OK" }
}
