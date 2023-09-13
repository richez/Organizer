//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

enum ProjectListViewModelError: RenderableError {
    case fetch(Error)
    case notFound(Error?)
    case delete(Error)

    var title: String {
        switch self {
        case .fetch:
            return "Fail to fetch projects"
        case .notFound:
            return "Fail to find project in database"
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
                    theme: project.themes.map { "#\($0)" }.joined(separator: " "),
                    statistics: project.statistics,
                    lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
                )
            }
        } catch {
            throw ProjectListViewModelError.fetch(error)
        }
    }

    func project(with projectID: UUID?) throws -> Project {
        guard let projectID else { throw ProjectListViewModelError.notFound(nil) }

        do {
            return try self.dataStore.project(with: projectID)
        } catch {
            throw ProjectListViewModelError.notFound(error)
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

private extension Project {
    var statistics: String {
        guard let contentStatistics else { return "" }
        return "\(contentStatistics) (\(contentTypeStatistics))"
    }

    var contentStatistics: String? {
        return self.pluralize("content", count: self.contents.count)
    }

    var contentTypeStatistics: String {
        return ProjectContentType.allCases.compactMap { type in
            let numberOfContent =  self.contents.lazy.filter { $0.type == type }.count
            return self.pluralize(type.rawValue, count: numberOfContent)
        }.joined(separator: ", ")
    }

    func pluralize(_ value: String, count: Int) -> String? {
        guard count > 0 else { return nil }
        return count >= 2 ? "\(count) \(value)s" : "\(count) \(value)"
    }
}
