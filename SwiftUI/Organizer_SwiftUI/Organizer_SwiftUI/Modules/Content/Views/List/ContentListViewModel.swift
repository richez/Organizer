//
//  ContentListViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
import SwiftData

extension ContentListView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ContentStoreOperations

        // MARK: - Initialization

        init(store: ContentStoreOperations = ContentStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func delete(_ content: ProjectContent, in context: ModelContext) {
            self.store.delete(content, in: context)
        }

        func themes(in project: Project) -> [String] {
            self.store.themes(in: project)
        }
    }
}
