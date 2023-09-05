//
//  ProjectsViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

protocol ProjectsViewModelProtocol {
    var navigationBarTitle: String { get }
    var projectsSections: [ProjectsSections] { get }
    var projectsData: [ProjectsCellData] { get }
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

    var projectsSections: [ProjectsSections] { [.main] }
    var projectsData: [ProjectsCellData] { self.projects.map(ProjectsCellData.init) }
}
