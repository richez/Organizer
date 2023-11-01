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

        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(formatter: ContentFormatterProtocol = ContentFormatter.shared) {
            self.formatter = formatter
        }

        // MARK: - Public

        func numberOfContents(in project: Project) -> Int {
            project.contents.count
        }

        func numberOfThemes(in project: Project) -> Int {
            self.formatter.themes(from: project.contents).count
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
            let format: Date.FormatStyle = .dateTime
                .day(.defaultDigits)
                .month(.abbreviated)
                .year(.defaultDigits)
                .hour(.conversationalTwoDigits(amPM: .wide))
                .minute(.twoDigits)
            return date.formatted(format)
        }
    }
}
