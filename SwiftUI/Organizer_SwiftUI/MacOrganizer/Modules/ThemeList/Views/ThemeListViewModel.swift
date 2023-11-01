//
//  ThemeListViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

extension ThemeListView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ProjectStoreReader

        // MARK: - Initialization

        init(store: ProjectStoreReader = ProjectStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func themeTypes(in projects: [Project]) -> [ThemeType] {
            return [.all] + self.store.themes(in: projects).map(ThemeType.custom)
        }
    }
}
