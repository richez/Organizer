//
//  Project.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation
import SwiftData

// TODO: - Add Menu Navbar for sorting / Preview (show stats) / edit
// TODO: - Show link on content selection - (long press to open in external browser?)
// TODO: - Share content with app
// TODO: - Add "Get link metadata" to content creation

@Model
final class Project {
    @Attribute(.unique) let id: UUID
    var title: String
    var themes: [String]
    @Relationship(deleteRule: .cascade)
    var contents: [ProjectContent]
    var creationDate: Date
    var lastUpdatedDate: Date

    init(id: UUID,
         title: String,
         themes: [String],
         contents: [ProjectContent],
         creationDate: Date,
         lastUpdatedDate: Date) {
        self.id = id
        self.title = title
        self.themes = themes
        self.contents = contents
        self.creationDate = creationDate
        self.lastUpdatedDate = lastUpdatedDate
    }
}
