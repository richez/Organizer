//
//  ProjectListViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

enum ProjectListViewModelError: RenderableError {
    case fetch(Error)
    case notFound(Error?)
    case delete(Error)
    case duplicate(Error)

    var title: String {
        switch self {
        case .fetch:
            return "Fail to fetch projects"
        case .notFound:
            return "Fail to find project in database"
        case .delete:
            return "Fail to delete project"
        case .duplicate:
            return "Fail to duplicate project"
        }
    }

    var message: String { "Please try again later" }

    var actionTitle: String { "OK" }
}
