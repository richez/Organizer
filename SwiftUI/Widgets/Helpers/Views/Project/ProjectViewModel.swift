//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import Foundation

extension ProjectView {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let project: Project
        private let formatter: ProjectFormatterProtocol

        // MARK: - Initialization

        init(project: Project, formatter: ProjectFormatterProtocol = ProjectFormatter()) {
            self.project = project
            self.formatter = formatter
        }

        // MARK: - Public

        var projectID: String {
            self.project.identifier.uuidString
        }

        var title: String {
            self.project.title
        }

        var themes: String {
            self.formatter.themes(from: self.project.theme)
        }

        var statistics: String {
            self.formatter.statistics(from: self.project.contents)
        }
    }
}
