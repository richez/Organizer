//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ProjectView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ProjectStoreDescriptor

        // MARK: - Initialization

        init(store: ProjectStoreDescriptor = ProjectStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func navbarSubtitle(with selectedTheme: String?) -> String {
            self.store.filtersDescription(for: selectedTheme)
        }
    }
}
