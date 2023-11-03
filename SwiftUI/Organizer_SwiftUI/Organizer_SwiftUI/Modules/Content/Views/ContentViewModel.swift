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

        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(formatter: ContentFormatterProtocol = ContentFormatter()) {
            self.formatter = formatter
        }

        // MARK: - Public

        func navbarSubtitle(with selectedTheme: String?, selectedType: ProjectContentType?) -> String {
            self.formatter.filtersDescription(from: selectedTheme, selectedType: selectedType)
        }
    }
}
