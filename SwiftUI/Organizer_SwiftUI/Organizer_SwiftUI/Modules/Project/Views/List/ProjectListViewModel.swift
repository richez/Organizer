//
//  ProjectListViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
import SwiftData

extension ProjectListView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ProjectStoreOperations
        private let formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(store: ProjectStoreOperations = ProjectStore.shared,
             formatter: ProjectFormatterProtocol = ProjectFormatter()
        ) {
            self.store = store
            self.formatter = formatter
        }

        // MARK: - Public

        func duplicate(_ project: Project, in context: ModelContext) {
            self.store.duplicate(project, in: context)
        }

        func delete(_ project: Project, in context: ModelContext) {
            self.store.delete(project, in: context)
        }

        func themes(in context: ModelContext) -> [String] {
            let projects = self.store.projects(propertiesToFetch: [\.theme], in: context)
            return self.formatter.themes(from: projects)
        }
    }
}
