//
//  ProjectsViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

// TODO: remove protocol ?
protocol ProjectsViewModelProtocol {
    var navigationBarTitle: String { get }
    var projectsSection: ProjectsSection { get }
    var projectsData: [ProjectCellData] { get }
}

struct ProjectsViewModel {
    private let projects: [Projects]

    init(projects: [Projects]) {
        self.projects = projects
    }
}

// MARK: - ProjectsViewModelProtocol

extension ProjectsViewModel: ProjectsViewModelProtocol {
    var navigationBarTitle: String { "Projects" }

    var projectsSection: ProjectsSection { .main }
    var projectsData: [ProjectCellData] { self.projects.map(ProjectCellData.init) }
}
