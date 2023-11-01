//
//  ContentViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ContentView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ContentStoreDescriptor

        // MARK: - Initialization

        init(store: ContentStoreDescriptor = ContentStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func navbarSubtitle(with selectedTheme: String?, selectedType: ProjectContentType?) -> String {
            self.store.filtersDescription(for: selectedTheme, selectedType: selectedType)
        }
    }
}
