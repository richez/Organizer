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
    @Relationship(deleteRule: .cascade)
    var contents: [ProjectContent]
    var createdDate: Date
    var updatedDate: Date

    init(id: UUID,
         title: String,
         theme: String,
         contents: [ProjectContent],
         createdDate: Date,
         updatedDate: Date) {
        self.id = id
        self.title = title
        self.theme = theme
        self.contents = contents
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

extension Project {
    @Transient
    var themes: [String] { self.theme.words }
}
