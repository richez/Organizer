//
//  ProjectStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import OSLog
import SwiftData

struct ProjectStore {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}

// MARK: - ProjectStoreDescriptor

extension ProjectStore: ProjectStoreDescriptor {
    func sortDescriptor(sorting: ProjectListSorting, isAscendingOrder: Bool) -> SortDescriptor<Project> {
        switch sorting {
        case .updatedDate:
            let order: SortOrder = isAscendingOrder ? .reverse : .forward
            return SortDescriptor(\.updatedDate, order: order)
        case .createdDate:
            let order: SortOrder = isAscendingOrder ? .reverse : .forward
            return SortDescriptor(\.createdDate, order: order)
        case .title:
            let order: SortOrder = isAscendingOrder ? .forward : .reverse
            return SortDescriptor(\.title, comparator: .localizedStandard, order: order)
        }
    }

    func predicate(selectedTeme: String?) -> Predicate<Project>? {
        switch selectedTeme {
        case .none:
            return nil
        case .some(let theme):
            return #Predicate {
                $0.theme.contains(theme)
            }
        }
    }
}

// MARK: - ProjectStoreReader

extension ProjectStore: ProjectStoreReader {
    func project(with persistentModelID: PersistentIdentifier, in context: ModelContext) -> Project? {
        guard let project = context.model(for: persistentModelID) as? Project else {
            return nil
        }

        return project
    }

    func project(with identifier: UUID, in context: ModelContext) -> Project? {
        var descriptor = FetchDescriptor<Project>(predicate: #Predicate {
            $0.identifier == identifier
        })
        descriptor.fetchLimit = 1
        let projects = (try? context.fetch(descriptor)) ?? []
        return projects.first
    }

    func projects(propertiesToFetch: [PartialKeyPath<Project>], in context: ModelContext) -> [Project] {
        var descriptor = FetchDescriptor<Project>()
        descriptor.propertiesToFetch = propertiesToFetch
        return (try? context.fetch(descriptor)) ?? []
    }
}

// MARK: - ProjectStoreWritter

extension ProjectStore: ProjectStoreWritter {
    func create(_ project: Project, in context: ModelContext) {
        context.insert(project)

        Logger.swiftData.info("Project \(project) inserted")
    }

    func create(_ project: Project, contents: [ProjectContent], in context: ModelContext) {
        self.create(project, in: context)
        contents.forEach { $0.project = project }
        project.contents = contents

        Logger.swiftData.info("Project \(project) inserted with contents \(contents)")
    }

    func update(_ project: Project, with values: ProjectValues) {
        let title = values.title
        let theme = values.theme

        let hasChanges = title != project.title || theme != project.theme

        if hasChanges {
            project.title = title
            project.theme = theme
            project.updatedDate = .now

            Logger.swiftData.info("Project \(project) updated with values \(values)")
        }
    }

    func duplicate(_ project: Project, in context: ModelContext) {
        let duplicatedProject = self.duplicate(project: project)
        context.insert(duplicatedProject)

        let duplicatedContents = project.contents.map(self.duplicate(content:))
        duplicatedContents.forEach { $0.project = duplicatedProject }
        duplicatedProject.contents = duplicatedContents

        Logger.swiftData.info("Project \(project) duplicated in \(duplicatedProject.identifier)")
    }
    
    func delete(_ project: Project, in context: ModelContext) {
        self.defaults.removePersistentDomain(forName: project.identifier.uuidString)
        context.delete(project)

        Logger.swiftData.info("Project \(project) deleted")
    }
}

private extension ProjectStore {
    /// Duplicates the specified ``Project`` by adding a 'copy' suffix to the title.
    /// The created and last updated date are set to the current date.
    func duplicate(project: Project) -> Project {
        .init(
            title: project.title + " copy",
            theme: project.theme
        )
    }

    /// Duplicates the specified ``ProjectContent``.
    /// The created and last updated date are kept in order to have the same
    /// ordering when displaying the new copied project contents.
    func duplicate(content: ProjectContent) -> ProjectContent {
        .init(
            type: content.type,
            title: content.title,
            theme: content.theme,
            url: content.url,
            createdDate: content.createdDate,
            updatedDate: content.updatedDate
        )
    }
}
