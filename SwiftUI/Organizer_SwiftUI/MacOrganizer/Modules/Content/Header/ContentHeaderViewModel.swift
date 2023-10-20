//
//  ContentHeaderViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

extension ContentHeaderView {
    struct ViewModel {
        func themes(in project: Project) -> [String] {
            return project.contents
                .flatMap(\.themes)
                .removingDuplicates()
        }

        func filters(
            selectedTheme: String?,
            selectedType: ProjectContentType?
        ) -> String {
            switch (selectedTheme, selectedType) {
            case (.none, .none):
                return ""
            case (.none, .some(let selectedType)):
                return "\(selectedType.rawValue)s"
            case (.some(let selectedTheme), .none):
                return "#\(selectedTheme)"
            case (.some(let selectedTheme), .some(let selectedType)):
                return "#\(selectedTheme) - \(selectedType.rawValue)s"
            }
        }
    }
}
