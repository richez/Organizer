//
//  ProjectsDataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectsDataStore {
    private let projects: [Projects]

    init(projects: [Projects]) {
        self.projects = projects
    }

    var sections: [ProjectsSection] = [.main]

    func projectsCellData(for section: ProjectsSection) -> [ProjectCellData] {
        switch section {
    case .main:
            return self.projects.map(ProjectCellData.init)
        }
    }
}
