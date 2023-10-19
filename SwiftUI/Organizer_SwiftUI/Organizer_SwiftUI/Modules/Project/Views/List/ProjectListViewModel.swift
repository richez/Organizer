//
//  ProjectListViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation
import SwiftData

extension ProjectListView {
    struct ViewModel {
        var defaults: UserDefaults = .standard

        func duplicate(_ project: Project, in context: ModelContext) {
            let duplicatedProject = self.duplicate(project: project)
            context.insert(duplicatedProject)

            let duplicatedContents = project.contents.map(self.duplicate(content:))
            duplicatedContents.forEach { $0.project = duplicatedProject }
            duplicatedProject.contents = duplicatedContents
        }

        func delete(_ project: Project, in context: ModelContext) {
            self.defaults.removePersistentDomain(forName: project.suiteName)
            context.delete(project)
        }

        // TODO: sort theme
        func themes(in context: ModelContext) -> [String] {
            var descriptor = FetchDescriptor<Project>()
            descriptor.propertiesToFetch = [\.theme]
            let allProjects = (try? context.fetch(descriptor)) ?? []
            return allProjects.flatMap(\.themes).removingDuplicates()
        }
    }
}

private extension ProjectListView.ViewModel {
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
