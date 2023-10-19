//
//  ThemeListViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

extension ThemeListView {
    struct ViewModel {
        func themeTypes(in projects: [Project]) -> [ThemeType] {
            let themes = projects.lazy
                .flatMap(\.themes)
                .map(ThemeType.custom)
                .removingDuplicates()
            return [.all] + themes
        }
    }
}
