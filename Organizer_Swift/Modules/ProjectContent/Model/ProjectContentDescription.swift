//
//  ProjectContentDescription.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

struct ProjectContentDescription: Hashable {
    var id: UUID
    var type: ProjectContentType
    var title: String
    var theme: String?
}

extension ProjectContentDescription {
    static let sample: [ProjectContentDescription] = [
        .init(id: UUID(), type: .article, title: "Quel isolant choisir", theme: "Isolation"),
        .init(id: UUID(), type: .link, title: "Laine de verre avantages et inconvenient", theme: "Isolation"),
        .init(id: UUID(), type: .video, title: "Fondations d'une tiny house", theme: "Foundation")
    ]
}
