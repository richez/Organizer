//
//  StatisticsViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension StatisticsView {
    struct ViewModel {
        // MARK: - Properties

        private let projectFormatter: ProjectFormatterProtocol
        private let contentFormatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(projectFormatter: ProjectFormatterProtocol = ProjectFormatter.shared,
            contentFormatter: ContentFormatterProtocol = ContentFormatter()
        ) {
            self.projectFormatter = projectFormatter
            self.contentFormatter = contentFormatter
        }

        // MARK: - Public

        func numberOfContents(in project: Project) -> Int {
            project.contents.count
        }

        func numberOfThemes(in project: Project) -> Int {
            self.contentFormatter.themes(from: project.contents).count
        }

        func contentTypeCounts(in project: Project) -> [String: Int] {
            project.contents.count(by: \.type.rawValue)
        }

        func contentThemeCounts(in project: Project) -> [String: Int] {
            project.contents.lazy
                .flatMap(\.theme.words)
                .count(by: \.self)
        }

        func formattedDate(from date: Date) -> String {
            self.projectFormatter.string(from: date, format: .full)
        }
    }
}
