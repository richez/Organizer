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
    var title: String
    var theme: String
    @Relationship(deleteRule: .cascade)
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
}

extension String {
    /// A collection of all the words in the string separated by punctuations or spaces.
    var words: [String] {
        self.components(separatedBy: .alphanumerics.inverted).filter { !$0.isEmpty }
    }
}
