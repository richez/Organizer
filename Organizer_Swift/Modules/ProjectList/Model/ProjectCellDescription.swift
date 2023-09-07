//
//  ProjectsCellData.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectCellDescription: Hashable {
    var id: UUID
    var title: String
    var lastUpdatedDate: String

    init(project: Project) {
        self.id = project.id
        self.title = project.title
        // TODO: this should be done in a VM
        self.lastUpdatedDate = project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
    }
}
