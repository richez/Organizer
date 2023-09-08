//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

enum ProjectListViewModelError: Error {
    case invalid(id: UUID)
}

final class ProjectListViewModel {
    let navigationBarTitle: String = "Projects"
    let section: ProjectListSection = .main
    private var projects: [Project] = []

    func fetchProjectDescriptions() -> [ProjectDescription] {
        let projects = Project.sample
        self.projects = projects
        return projects.map { project in
            return ProjectDescription(
                id: project.id,
                title: project.title,
                lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
            )
        }
    }

    func deleteProject(with id: UUID) throws {
        guard let index = self.projects.firstIndex(where: { $0.id == id }) else {
            throw ProjectListViewModelError.invalid(id: id)
        }

        self.projects.remove(at: index)
    }
}
