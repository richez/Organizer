//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class ProjectListViewModel {
    // MARK: - Properties

    private let dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter
    private var settings: ProjectListSettings
    private let fetchDescriptor: ProjectListFetchDescriptorProtocol
    private let menuConfigurator: ProjectListMenuConfiguratorProtocol

    // MARK: - Initialization

    init(dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter,
         settings: ProjectListSettings,
         fetchDescriptor: ProjectListFetchDescriptorProtocol,
         menuConfigurator: ProjectListMenuConfiguratorProtocol) {
        self.dataStore = dataStore
        self.settings = settings
        self.fetchDescriptor = fetchDescriptor
        self.menuConfigurator = menuConfigurator
    }
}

// MARK: - Public

extension ProjectListViewModel {
    // MARK: Properties

    var navigationBarTitle: String {
        switch self.settings.selectedTheme {
        case .all:
            return "Projects"
        case .custom(let selectedTheme):
            return "Projects\n#\(selectedTheme)"
        }
    }

    var rightBarImageName: String { "ellipsis" }
    var section: ProjectListSection { .main }

    var viewConfiguration: ProjectListViewConfiguration {
        .init(
            createButtonImageName: "square.and.pencil",
            swipeActions: [
                ProjectListSwipeActionConfiguration(imageName: "trash", action: .delete),
                ProjectListSwipeActionConfiguration(imageName: "square.and.pencil", action: .edit)
            ],
            contextMenuTitle: "",
            contextMenuActions: [
                ProjectListContextMenuActionConfiguration(title: "Archive", imageName: "archivebox", action: .archive),
                ProjectListContextMenuActionConfiguration(title: "Edit", imageName: "square.and.pencil", action: .edit),
                ProjectListContextMenuActionConfiguration(title: "Delete", imageName: "trash", action: .delete)
            ]
        )
    }

    // MARK: Data

    func fetchProjectDescriptions() throws -> [ProjectDescription] {
        do {
            return try self.dataStore
                .fetch(predicate: self.fetchDescriptor.predicate, sortBy: self.fetchDescriptor.sortDescriptor)
                .map { project in
                    ProjectDescription(
                        id: project.id,
                        title: project.title,
                        theme: self.theme(for: project),
                        statistics: self.statistics(for: project),
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

    // MARK: Menu

    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let numberOfProjects = try? self.dataStore.fetchCount(predicate: self.fetchDescriptor.predicate, sortBy: [])
        let allExistingThemes = try? self.dataStore
            .fetch(predicate: nil, sortBy: [])
            .flatMap(\.themes)
            .removingDuplicates()
        return self.menuConfigurator.configuration(
            numberOfProjects: numberOfProjects ?? 0,
            themes: allExistingThemes ?? [],
            handler: handler
        )
    }
}

// MARK: - Helpers

private extension ProjectListViewModel {
    // MARK: Project

    func theme(for project: Project) -> String? {
        guard self.settings.showTheme else { return nil }
        return project.themes.map { "#\($0)" }.joined(separator: " ")
    }

    func statistics(for project: Project) -> String? {
        guard self.settings.showStatistics,
                let contentStatistics = "content".pluralize(count: project.contents.count) else {
            return nil
        }

        let contentTypeStatistics = ProjectContentType.allCases.compactMap { type in
            let numberOfContent =  project.contents.lazy.filter { $0.type == type }.count
            return type.rawValue.pluralize(count: numberOfContent)
        }.joined(separator: ", ")

        return "\(contentStatistics) (\(contentTypeStatistics))"
    }
}
