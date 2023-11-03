//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        // MARK: - Properties

        var formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(formatter: ProjectFormatterProtocol = ProjectFormatter()) {
            self.formatter = formatter
        }

        // MARK: - Public

        func statistics(from contents: [ProjectContent]) -> String {
            self.formatter.statistics(from: contents)
        }
    }
}
