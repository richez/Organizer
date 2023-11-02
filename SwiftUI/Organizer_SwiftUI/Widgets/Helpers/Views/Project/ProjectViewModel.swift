//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import Foundation

extension ProjectView {
    struct ViewModel {
        // MARK: - Properties

        var formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter.shared) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themes(from theme: String) -> String {
            self.formatter.themes(from: theme)
        }

        func statistics(from contents: [ProjectContent]) -> String {
            self.formatter.statistics(from: contents)
        }
    }
}
