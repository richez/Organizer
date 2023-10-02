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
    var theme: String
    var link: String
    var createdDate: Date
    var updatedDate: Date

    init(id: UUID,
         type: ProjectContentType,
         title: String,
         theme: String,
         link: String,
         createdDate: Date,
         updatedDate: Date) {
        self.id = id
        self.type = type
        self.title = title
        self.theme = theme
        self.link = link
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension ProjectContent {
    @Transient
    var themes: [String] { self.theme.words }
}
