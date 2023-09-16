//
//  Project.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation
import SwiftData

// TODO: - Add Swipe actions on cell to edit / delete
// TODO: - Add context menu to table view cell to edit / delete / open external browser for content
// TODO: - Share content with app
// TODO: - Add "Get link metadata" to content creation

@Model
final class Project {
    @Attribute(.unique) let id: UUID
    var title: String
    var theme: String
    @Relationship(deleteRule: .cascade)
    var contents: [ProjectContent]
    var creationDate: Date
    var lastUpdatedDate: Date

    var themes: [String] { self.theme.words }

    init(id: UUID,
         title: String,
         theme: String,
         contents: [ProjectContent],
         creationDate: Date,
         lastUpdatedDate: Date) {
        self.id = id
        self.title = title
        self.theme = theme
        self.contents = contents
        self.creationDate = creationDate
        self.lastUpdatedDate = lastUpdatedDate
    }
}
