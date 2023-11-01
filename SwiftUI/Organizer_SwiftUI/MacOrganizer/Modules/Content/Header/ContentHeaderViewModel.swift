//
//  ContentHeaderViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ContentHeaderView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ContentStoreDescriptor & ContentStoreReader

        // MARK: - Initialization

        init(store: ContentStoreDescriptor & ContentStoreReader = ContentStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func themes(in project: Project) -> [String] {
            self.store.themes(in: project)
        }

        func filters(with selectedTheme: String?, selectedType: ProjectContentType?) -> String {
            self.store.filtersDescription(for: selectedTheme, selectedType: selectedType)
        }
    }
}
