//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        // MARK: - Properties

        private let formatter: ProjectFormatterProtocol

        // MARK: Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter()) {
            self.formatter = formatter
        }

        // MARK: - Public

        func themes(from theme: String) -> String {
            self.formatter.themes(from: theme)
        }

        func statistics(from contents: [ProjectContent]) -> String {
            self.formatter.statistics(from: contents)
        }

        func updatedDate(from date: Date) -> String {
            self.formatter.string(from: date, format: .abbreviated)
        }
    }
}
