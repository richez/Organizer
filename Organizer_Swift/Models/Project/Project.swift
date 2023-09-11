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
    var theme: String? // TODO: display theme in cell + add creation date
    var lastUpdatedDate: Date

    init(id: UUID = .init(), title: String, theme: String? = nil, lastUpdatedDate: Date) {
        self.id = id
        self.title = title
        self.theme = theme
        self.lastUpdatedDate = lastUpdatedDate
    }
}
