//
//  ProjectContent.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation
import SwiftData

enum ProjectContentType: Int, Codable {
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
    var theme: String?
    var link: String
    var creationDate: Date
    var lastUpdatedDate: Date

    init(id: UUID,
         type: ProjectContentType,
         title: String,
         theme: String?,
         link: String,
         creationDate: Date,
         lastUpdatedDate: Date) {
        self.id = id
        self.type = type
        self.title = title
        self.theme = theme
        self.link = link
        self.creationDate = creationDate
        self.lastUpdatedDate = lastUpdatedDate
    }
}
