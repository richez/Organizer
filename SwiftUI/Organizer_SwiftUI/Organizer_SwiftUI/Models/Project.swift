//
//  Project.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import Foundation
import SwiftData

// TODO: add statictis popover on macOS
// TODO: add lazy to array when needed
// TODO: handle deeplink to open project / content
// TODO: Widgets -> handle reload only from app (TimelineReloadPolicy.never) -> store id of edited project and reload when app becomes inactive to avoid unnecessary updates
// https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date
// TODO:    - Small: project row like
// TODO:    - Medium/Large: list of 3/5 content
@Model
final class Project {
    var title: String
    var theme: String
    @Relationship(deleteRule: .cascade, inverse: \ProjectContent.project)
    var contents: [ProjectContent]
    var createdDate: Date
    var updatedDate: Date

    init(title: String = "",
         theme: String = "",
         contents: [ProjectContent] = [],
         createdDate: Date = .now,
         updatedDate: Date = .now) {
        self.title = title
        self.theme = theme
        self.contents = contents
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension Project {
    var themes: [String] { self.theme.words }

    var suiteName: String {
        "\(self.title.words.joined())-\(self.createdDate.timeIntervalSince1970)"
    }
}
