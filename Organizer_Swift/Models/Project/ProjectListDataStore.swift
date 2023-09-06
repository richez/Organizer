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

    func projectListCellData(for section: ProjectListSection) -> [ProjectCellData] {
        switch section {
        case .main:
            return self.projects.map(ProjectCellData.init)
        }
    }

    func projectCellData(at indexPath: IndexPath) -> ProjectCellData? {
        guard self.projects.indices.contains(indexPath.row) else { return nil }

        let project = self.projects[indexPath.row]
        return ProjectCellData(project: project)
    }

    func deleteProject(with id: UUID) {
        guard let index = self.projects.firstIndex(where: { $0.id == id }) else {
            return
        }

        self.projects.remove(at: index)
    }
}
