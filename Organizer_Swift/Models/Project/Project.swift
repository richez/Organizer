//
//  Project.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation
import SwiftData

@Model
final class Project {
    @Attribute(.unique) let id: UUID
    var title: String
    var theme: String
    var contents: [ProjectContent] // TODO: add cascade
    var creationDate: Date
    var lastUpdatedDate: Date

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
