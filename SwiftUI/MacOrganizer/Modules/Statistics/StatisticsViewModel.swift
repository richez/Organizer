//
//  StatisticsViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension StatisticsView {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let project: Project
        private let projectFormatter: ProjectFormatterProtocol
        private let contentFormatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(
            project: Project,
            projectFormatter: ProjectFormatterProtocol = ProjectFormatter(),
            contentFormatter: ContentFormatterProtocol = ContentFormatter()
        ) {
            self.project = project
            self.projectFormatter = projectFormatter
            self.contentFormatter = contentFormatter
        }

        // MARK: - Public

        var numberOfContents: Int {
            self.project.contents.count
        }

        var numberOfThemes: Int {
            self.contentFormatter.themes(from: self.project.contents).count
        }

        var contentTypeCounts: [String: Int] {
            self.project.contents.count(by: \.type.rawValue)
        }

        var contentThemeCounts: [String: Int] {
            self.project.contents.lazy
                .flatMap(\.theme.words)
                .count(by: \.self)
        }

        var createdDate: String {
            self.projectFormatter.string(from: self.project.createdDate, format: .full)
        }

        var updatedDate: String {
            self.projectFormatter.string(from: self.project.updatedDate, format: .full)
        }
    }
}
