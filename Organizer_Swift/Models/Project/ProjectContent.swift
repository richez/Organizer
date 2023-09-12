//
//  ProjectContent.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation
import SwiftData

enum ProjectContentType: String, CaseIterable, Codable {
    case article
    case note
    case video
    case other
}

@Model
final class ProjectContent {
    @Attribute(.unique) let id: UUID
    var type: ProjectContentType
    var title: String
    var themes: [String]
    var link: String
    var creationDate: Date
    var lastUpdatedDate: Date

    init(id: UUID,
         type: ProjectContentType,
         title: String,
         themes: [String],
         link: String,
         creationDate: Date,
         lastUpdatedDate: Date) {
        self.id = id
        self.type = type
        self.title = title
        self.themes = themes
        self.link = link
        self.creationDate = creationDate
        self.lastUpdatedDate = lastUpdatedDate
    }
}
