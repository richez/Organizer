//
//  ProjectsCellData.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectsCellData {
    var title: String

    init(projects: Projects) {
        self.title = projects.title
    }
}
