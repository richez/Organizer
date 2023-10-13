//
//  ProjectContent.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import Foundation
import SwiftData

enum ProjectContentType: String, Identifiable, CaseIterable, Codable {
    case article
    case note
    case video
    case other

    var id: ProjectContentType { self }
}

@Model
final class ProjectContent {
    // store the raw value to enable sorting and filtering
    var typeRawValue: String
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
        self.typeRawValue = type.rawValue
        self.title = title
        self.theme = theme
        self.link = link
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension ProjectContent {
    var themes: [String] { self.theme.words }
    var type: ProjectContentType { .init(rawValue: self.typeRawValue) ?? .other }
}
