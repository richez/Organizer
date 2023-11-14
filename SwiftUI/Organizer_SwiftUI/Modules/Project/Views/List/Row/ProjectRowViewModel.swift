//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let project: Project
        private let formatter: ProjectFormatterProtocol

        // MARK: Initialization

        init(project: Project, formatter: ProjectFormatterProtocol = ProjectFormatter()) {
            self.project = project
            self.formatter = formatter
        }

        // MARK: - Public

        var title: String {
            self.project.title
        }

        var themes: String {
            self.formatter.themes(from: self.project.theme)
        }

        var statistics: String {
            self.formatter.statistics(from: self.project.contents)
        }

        var updatedDate: String {
            self.formatter.string(from: self.project.updatedDate, format: .abbreviated)
        }
    }
}
