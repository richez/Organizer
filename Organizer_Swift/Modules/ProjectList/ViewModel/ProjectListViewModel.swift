//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectListViewModel {
    // MARK: - Properties

    private let dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter

    // MARK: - Initialization

    init(dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter = ProjectDataStore.shared) {
        self.dataStore = dataStore
    }
}

// MARK: - Public

extension ProjectListViewModel {
    var navigationBarTitle: String { "Projects" }
    var section: ProjectListSection { .main }

    func fetchProjectDescriptions() throws -> [ProjectDescription] {
        let projects = try self.dataStore.fetch()
        return projects.map { project in
            return ProjectDescription(
                id: project.id,
                title: project.title,
                theme: project.theme,
                lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
            )
        }
    }

    func deleteProject(with id: UUID) throws {
        try self.dataStore.delete(projectID: id)
    }
}
