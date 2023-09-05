//
//  ProjectsViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectsViewModel {
    private let projects: [Projects]

    init(projects: [Projects]) {
        self.projects = projects
    }
}

// MARK: - Public

extension ProjectsViewModel {
    var navigationBarTitle: String { "Projects" }

    var projectsSection: ProjectsSection { .main }
    var projectsData: [ProjectCellData] { self.projects.map(ProjectCellData.init) }
}
