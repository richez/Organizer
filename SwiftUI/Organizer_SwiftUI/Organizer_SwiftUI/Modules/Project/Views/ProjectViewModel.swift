//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ProjectView {
    struct ViewModel {
        // MARK: - Properties

        private let formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter.shared) {
            self.formatter = formatter
        }

        // MARK: - Public

        func navbarSubtitle(with selectedTheme: String?) -> String {
            self.formatter.filterDescription(from: selectedTheme)
        }
    }
}
