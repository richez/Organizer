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

        private let formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter.shared) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themeTypes(in projects: [Project]) -> [ThemeType] {
            return [.all] + self.formatter.themes(from: projects).map(ThemeType.custom)
        }
    }
}
