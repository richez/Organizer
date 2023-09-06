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

    init(project: Project) {
        self.id = project.id
        self.title = project.title
    }
}
