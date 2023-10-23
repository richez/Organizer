//
//  ThemeListViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

extension ThemeListView {
    struct ViewModel {
        var store: ProjectStoreReader = ProjectStore.shared

        func themeTypes(in projects: [Project]) -> [ThemeType] {
            return [.all] + self.store.themes(in: projects).map(ThemeType.custom)
        }
    }
}
