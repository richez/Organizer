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

        func delete(_ project: Project, from context: ModelContext) {
            self.defaults.removePersistentDomain(forName: project.suiteName)
            context.delete(project)
        }

        func themes(in context: ModelContext) -> [String] {
            var descriptor = FetchDescriptor<Project>()
            descriptor.propertiesToFetch = [\.theme]
            let allProjects = (try? context.fetch(descriptor)) ?? []
            return allProjects.flatMap(\.themes).removingDuplicates()
        }
    }
}
