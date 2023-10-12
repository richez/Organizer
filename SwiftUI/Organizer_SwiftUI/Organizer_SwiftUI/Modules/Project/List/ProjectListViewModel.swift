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
        func themes(in context: ModelContext) -> [ProjectListTheme] {
            var descriptor = FetchDescriptor<Project>()
            descriptor.propertiesToFetch = [\.theme]
            let allProjects = (try? context.fetch(descriptor)) ?? []
            let themes = allProjects.lazy
                .flatMap(\.themes)
                .map(ProjectListTheme.custom)
                .removingDuplicates()
            return [.all] + themes
        }
    }
}
