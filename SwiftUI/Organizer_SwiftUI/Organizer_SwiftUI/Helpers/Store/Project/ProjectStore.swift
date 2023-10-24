//
//  ProjectStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

struct ProjectStore {
    static let shared: ProjectStoreProtocol = ProjectStore()

    private let defaults: UserDefaults

    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}

// MARK: - ProjectStoreDescriptor

extension ProjectStore: ProjectStoreDescriptor {
    func filtersDescription(for selectedTheme: String?) -> String {
        switch selectedTheme {
        case .none: ""
        case .some(let theme): "#\(theme)"
        }
    }

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
    func project(with values: ProjectValues) -> Project {
        .init(
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func project(for persistentModelID: PersistentIdentifier, in context: ModelContext) -> Project? {
        guard let project = context.model(for: persistentModelID) as? Project else {
            return nil
        }

        return project
    }

    func project(for identifier: UUID, in context: ModelContext) -> Project? {
        var descriptor = FetchDescriptor<Project>(predicate: #Predicate {
            $0.identifier == identifier
        })
        descriptor.fetchLimit = 1
        let projects = (try? context.fetch(descriptor)) ?? []
        return projects.first
    }

    func themes(in context: ModelContext) -> [String] {
        var descriptor = FetchDescriptor<Project>()
        descriptor.propertiesToFetch = [\.theme]
        let projects = (try? context.fetch(descriptor)) ?? []
        return self.themes(in: projects)
    }

    func themes(in projects: [Project]) -> [String] {
        return projects.lazy
            .flatMap(\.themes)
            .removingDuplicates()
            .sorted(using: .localizedStandard)
    }
}

// MARK: - ProjectStoreWritter

extension ProjectStore: ProjectStoreWritter {
    @discardableResult
    func create(with values: ProjectValues, in context: ModelContext) -> Project {
        let project = self.project(with: values)
        context.insert(project)
        return project
    }

    @discardableResult
    func create(with values: ProjectValues, contents: [ProjectContent], in context: ModelContext) -> Project {
        let project = self.create(with: values, in: context)
        contents.forEach { $0.project = project }
        project.contents = contents
        return project
    }

    func update(_ project: Project, with values: ProjectValues) {
        let title = values.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)

        let hasChanges = title != project.title || theme != project.theme

        if hasChanges {
            project.title = title
            project.theme = theme
            project.updatedDate = .now
        }
    }

    @discardableResult
    func duplicate(_ project: Project, in context: ModelContext) -> Project {
        let duplicatedProject = self.duplicate(project: project)
        context.insert(duplicatedProject)

        let duplicatedContents = project.contents.map(self.duplicate(content:))
        duplicatedContents.forEach { $0.project = duplicatedProject }
        duplicatedProject.contents = duplicatedContents
        return duplicatedProject
    }
    
    func delete(_ project: Project, in context: ModelContext) {
        self.defaults.removePersistentDomain(forName: project.identifier.uuidString)
        context.delete(project)
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
            link: content.link,
            createdDate: content.createdDate,
            updatedDate: content.updatedDate
        )
    }
}
