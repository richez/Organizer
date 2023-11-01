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

        // MARK: - Initialization

        init(store: ProjectStoreOperations = ProjectStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func duplicate(_ project: Project, in context: ModelContext) {
            self.store.duplicate(project, in: context)
        }

        func delete(_ project: Project, in context: ModelContext) {
            self.store.delete(project, in: context)
        }

        func themes(in context: ModelContext) -> [String] {
            self.store.themes(in: context)
        }
    }
}
