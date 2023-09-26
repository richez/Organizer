//
//  ContentListViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

enum ContentListViewModelError: RenderableError {
    case fetch(Error)
    case notFound(UUID)
    case badLink(String)
    case delete(UUID)

    var title: String {
        switch self {
        case .fetch:
            return "Fail to fetch project contents"
        case .notFound:
            return "Fail to find content in database"
        case .badLink(let link):
            return "The content link is malformatted: '\(link)'"
        case .delete:
            return "Fail to delete project content"
        }
    }

    var message: String { "Please try again later" }

    var actionTitle: String { "OK" }
}
