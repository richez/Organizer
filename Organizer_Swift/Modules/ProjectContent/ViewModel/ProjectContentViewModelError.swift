//
//  ProjectContentViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

enum ProjectContentViewModelError: RenderableError {
    case delete(UUID)

    var title: String {
        switch self {
        case .delete:
            return "Fail to delete project"
        }
    }

    var message: String { "Please try again later" }

    var actionTitle: String { "OK" }
}