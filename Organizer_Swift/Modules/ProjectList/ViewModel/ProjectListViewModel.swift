//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation
import SwiftData

struct ProjectListViewModel {
    // MARK: - Properties

    private let dataStore: DataStoreProtocol
    private let settings: ProjectListSettings
    private let fetchDescriptor: ProjectListFetchDescriptorProtocol
    private let menuConfigurator: ProjectListMenuConfiguratorProtocol

    // MARK: - Initialization

    init(dataStore: DataStoreProtocol,
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
                ProjectListContextMenuActionConfiguration(title: "Duplicate", imageName: "doc.on.doc", action: .duplicate),
                ProjectListContextMenuActionConfiguration(title: "Edit", imageName: "square.and.pencil", action: .edit),
                ProjectListContextMenuActionConfiguration(title: "Delete", imageName: "trash", action: .delete)
            ]
        )
    }

    // MARK: Data

    /// Returns an array of ``ProjectDescription`` from the persistent stores that meet the criteria of the
    /// ``ProjectListFetchDescriptor/predicate`` and ``ProjectListFetchDescriptor/sortDescriptor`` formatted
    /// to be ready to be displayed in a ``ProjectCell`` or throw a ``ProjectListViewModelError/fetch(_:)`` error.
    func fetchProjectDescriptions() throws -> [ProjectDescription] {
        do {
            return try self.dataStore
                .fetch(predicate: self.fetchDescriptor.predicate, sortBy: self.fetchDescriptor.sortDescriptor)
                .map { project in
                    ProjectDescription(
                        id: project.persistentModelID,
                        title: project.title,
                        theme: self.theme(for: project),
                        statistics: self.statistics(for: project),
                        lastUpdatedDate: project.updatedDate.formatted(.dateTime.day().month(.abbreviated))
                    )
                }
        } catch {
            throw ProjectListViewModelError.fetch(error)
        }
    }

    /// Returns the ``Project`` associated with the specified identifier from the persistent store or
    /// throw a ``ProjectListViewModelError/notFound(_:)`` error.
    func project(with identifier: PersistentIdentifier) throws -> Project {
        do {
            return try self.dataStore.model(with: identifier)
        } catch {
            throw ProjectListViewModelError.notFound(error)
        }
    }

    /// Deletes the ``Project`` associated with the specified identifier in the persistent stores and
    /// its associated settings or throw a ``ProjectListViewModelError/delete(_:)`` error.
    func deleteProject(with identifier: PersistentIdentifier) throws {
        do {
            let project: Project = try self.dataStore.model(with: identifier)
            try self.dataStore.delete(model: project)
            self.settings.delete(suiteName: project.id.uuidString)
        } catch {
            throw ProjectListViewModelError.delete(error)
        }
    }

    /// Duplicates the ``Project`` associated with the specified identifier and add it in the persistent
    /// stores or throw a ``ProjectListViewModelError/duplicate(_:)`` error.
    func duplicateProject(with identifier: PersistentIdentifier) throws {
        do {
            let project: Project = try self.dataStore.model(with: identifier)
            let duplicatedProject = self.duplicate(project: project)
            try self.dataStore.create(model: duplicatedProject)
        } catch {
            throw ProjectListViewModelError.duplicate(error)
        }
    }

    // MARK: Menu

    /// Returns a ``MenuConfiguration`` by using the ``ProjectListMenuConfigurator`` with the number of
    /// projects represented by the ``ProjectListFetchDescriptor/predicate`` and the themes of all projects
    /// in the persistent stores.
    /// - Parameter handler: The action to be executed when a menu item is selected by the user.
    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let numberOfProjects = try? self.dataStore.fetchCount(predicate: self.fetchDescriptor.predicate)
        let allProjects: [Project]? = try? self.dataStore.fetch(predicate: nil, sortBy: [])
        let allExistingThemes = allProjects?.flatMap(\.themes).removingDuplicates()
        return self.menuConfigurator.configuration(
            numberOfProjects: numberOfProjects ?? 0,
            themes: allExistingThemes ?? [],
            handler: handler
        )
    }

    // MARK: Share Extension

    var shareExtensionDidAddContent: Bool {
        self.settings.group.shareExtensionDidAddContent
    }

    func resetShareExtensionSetting() {
        self.settings.group.shareExtensionDidAddContent = false
    }
}

// MARK: - Helpers

private extension ProjectListViewModel {
    // MARK: Project

    /// Returns a `String` that represent the themes of the specified ``Project``
    /// (ex: #DIY #Construction) if ``ProjectListSettings/showTheme`` is `true`,
    /// `nil` otherwise.
    func theme(for project: Project) -> String? {
        guard self.settings.showTheme else { return nil }
        return project.themes.map { "#\($0)" }.joined(separator: " ")
    }

    /// Returns a `String` that represents the descriptions of the specified ``Project`` content
    /// (ex: "4 contents (2 articles, 1 video, 4 notes)" if ``ProjectListSettings/showStatistics``
    /// is `true`, `nil` otherwise.
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

    /// Duplicates the specified ``Project`` by assigning a new `UUID` and adding
    /// a 'copy' suffix to the title. The created and last updated date are set to
    /// the current date.
    func duplicate(project: Project) -> Project {
        .init(
            id: UUID(),
            title: project.title + " copy",
            theme: project.theme,
            contents: project.contents.map(self.duplicate(content:)),
            createdDate: .now,
            updatedDate: .now
        )
    }

    /// Duplicates the specified ``ProjectContent`` by assigning a new `UUID`.
    /// The created and last updated date are kept in order to have the same
    /// ordering when displaying the new copied project contents.
    func duplicate(content: ProjectContent) -> ProjectContent {
        .init(
            id: UUID(),
            type: content.type,
            title: content.title,
            theme: content.theme,
            link: content.link,
            createdDate: content.createdDate,
            updatedDate: content.updatedDate
        )
    }
}
