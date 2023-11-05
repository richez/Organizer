//
//  ContentViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import Foundation

extension ContentView {
    struct ViewModel {
        // MARK: - Properties

        var formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter()) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themes(from theme: String) -> String {
            self.formatter.themes(from: theme)
        }
    }
}
