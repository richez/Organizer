//
//  Project.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import Foundation
import SwiftData

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

extension Project: CustomStringConvertible {
    var description: String {
        """
       \(self.title) (\(self.identifier)), \
       themes \(self.theme.words), \
       \(self.contents.count) contents, \
       created at \(self.createdDate), \
       updated at \(self.updatedDate)
       """
    }
}
