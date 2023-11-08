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

    var systemImage: String {
        switch self {
        case .article:
            return "newspaper"
        case .note:
            return "note"
        case .video:
            return "video"
        case .other:
            return "questionmark.square"
        }
    }
}

@Model
final class ProjectContent {
    var identifier: UUID
    // store the raw value to enable sorting and filtering
    var typeRawValue: String
    var title: String
    var theme: String
    var url: URL
    var createdDate: Date
    var updatedDate: Date

    var project: Project?

    init(identifier: UUID = .init(),
        type: ProjectContentType = .article,
         title: String = "",
         theme: String = "",
         url: URL,
         createdDate: Date = .now,
         updatedDate: Date = .now) {
        self.identifier = identifier
        self.typeRawValue = type.rawValue
        self.title = title
        self.theme = theme
        self.url = url
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension ProjectContent {
    var type: ProjectContentType { .init(rawValue: self.typeRawValue) ?? .other }
}

extension ProjectContent: CustomStringConvertible {
    var description: String {
        """
       \(self.title) (\(self.identifier)), \
       type \(self.typeRawValue), \
       themes \(self.theme.words), \
       url \(self.url) \
       created at \(self.createdDate), \
       updated at \(self.updatedDate)
       """
    }
}
