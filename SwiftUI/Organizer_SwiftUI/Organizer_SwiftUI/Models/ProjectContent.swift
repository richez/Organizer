//
//  ProjectContent.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
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
    var type: ProjectContentType
    var title: String
    var theme: String
    var link: String
    var createdDate: Date
    var updatedDate: Date

    var project: Project?

    init(type: ProjectContentType = .article,
         title: String = "",
         theme: String = "",
         link: String = "",
         createdDate: Date = .now,
         updatedDate: Date = .now) {
        self.type = type
        self.title = title
        self.theme = theme
        self.link = link
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}
