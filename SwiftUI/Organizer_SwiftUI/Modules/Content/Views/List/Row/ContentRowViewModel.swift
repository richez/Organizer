//
//  ContentRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentRow {
    struct ViewModel {
        // MARK: - Properties

        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(formatter: ContentFormatterProtocol = ContentFormatter()) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themes(from theme: String) -> String {
            self.formatter.themes(from: theme)
        }
    }
}
