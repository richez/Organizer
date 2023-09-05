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

    var projectsSections: [ProjectsSection] { [.main] }

    func projects(for section: ProjectsSection) -> [ProjectCellData] {
        switch section {
        case .main:
            return self.projects.map(ProjectCellData.init)
        }
    }
}
