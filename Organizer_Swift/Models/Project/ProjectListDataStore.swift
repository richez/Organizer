//
//  ProjectListDataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class ProjectListDataStore {
    private var projects: [Project]

    init(projects: [Project]) {
        self.projects = projects
    }
}

// MARK: - Public

extension ProjectListDataStore {
    var sections: [ProjectListSection] { [.main] }

    func projectCellDescriptions(for section: ProjectListSection) -> [ProjectCellDescription] {
        switch section {
        case .main:
            return self.projects.map(ProjectCellDescription.init)
        }
    }

    func projectCellDescription(at indexPath: IndexPath) -> ProjectCellDescription? {
        guard self.projects.indices.contains(indexPath.row) else { return nil }

        let project = self.projects[indexPath.row]
        return ProjectCellDescription(project: project)
    }

    func deleteProject(description: ProjectCellDescription) {
        guard let index = self.projects.firstIndex(where: { $0.id == description.id }) else {
            return
        }

        self.projects.remove(at: index)
    }
}
