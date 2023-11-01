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

        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(formatter: ContentFormatterProtocol = ContentFormatter.shared) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themes(in contents: [ProjectContent]) -> [String] {
            self.formatter.themes(from: contents)
        }

        func filters(with selectedTheme: String?, selectedType: ProjectContentType?) -> String {
            self.formatter.filtersDescription(from: selectedTheme, selectedType: selectedType)
        }
    }
}
