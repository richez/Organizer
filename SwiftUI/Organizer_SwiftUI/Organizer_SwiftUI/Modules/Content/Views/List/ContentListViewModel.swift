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
        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(store: ContentStoreOperations = ContentStore.shared,
             formatter: ContentFormatterProtocol = ContentFormatter.shared) {
            self.store = store
            self.formatter = formatter
        }

        // MARK: - Public

        func delete(_ content: ProjectContent, in context: ModelContext) {
            self.store.delete(content, in: context)
        }

        func themes(in contents: [ProjectContent]) -> [String] {
            self.formatter.themes(from: contents)
        }
    }
}
