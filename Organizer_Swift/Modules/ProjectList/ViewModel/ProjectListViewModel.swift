//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

enum ProjectListViewModelError: RenderableError {
    case fetch(Error)
    case delete(Error)

    var title: String {
        switch self {
        case .fetch:
            return "Fail to fetch projects"
        case .delete:
            return "Fail to delete project"
        }
    }

    var message: String { "Please try again later" }

    var actionTitle: String { "OK" }
}

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
        do {
            let projects = try self.dataStore.fetch()
            return projects.map { project in
                return ProjectDescription(
                    id: project.id,
                    title: project.title,
                    theme: project.theme,
                    lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
                )
            }
        } catch {
            throw ProjectListViewModelError.fetch(error)
        }
    }

    func deleteProject(with id: UUID) throws {
        do {
            try self.dataStore.delete(projectID: id)
        } catch {
            throw ProjectListViewModelError.delete(error)
        }
    }
}
