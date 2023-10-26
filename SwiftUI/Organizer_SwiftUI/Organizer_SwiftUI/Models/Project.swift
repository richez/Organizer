//
//  Project.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import Foundation
import SwiftData

// TODO: Add relationshipKeyPathsForPrefetching for contents (used directly for stats)
// TODO: Widgets -> handle reload only from app (TimelineReloadPolicy.never) -> store id of edited project and reload when app becomes inactive to avoid unnecessary updates
// https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date
// TODO:    - Small: project row like with add button to create content (add deeplink)
// TODO:    - Medium/Large: list of 3/5 content
@Model
final class Project {
    var identifier: UUID
    var title: String
    var theme: String
    @Relationship(deleteRule: .cascade, inverse: \ProjectContent.project)
    var contents: [ProjectContent]
    var createdDate: Date
    var updatedDate: Date

    init(identifier: UUID = .init(),
        title: String = "",
         theme: String = "",
         contents: [ProjectContent] = [],
         createdDate: Date = .now,
         updatedDate: Date = .now) {
        self.identifier = identifier
        self.title = title
        self.theme = theme
        self.contents = contents
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension Project {
    var themes: [String] { self.theme.words }
}
