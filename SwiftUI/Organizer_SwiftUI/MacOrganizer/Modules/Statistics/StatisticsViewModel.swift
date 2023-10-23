//
//  StatisticsViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension StatisticsView {
    struct ViewModel {
        func numberOfContents(in project: Project) -> Int {
            project.contents.count
        }

        func numberOfThemes(in project: Project) -> Int {
            project.contents.lazy
                .flatMap(\.themes)
                .removingDuplicates()
                .count
        }

        func contentTypeCounts(in project: Project) -> [String: Int] {
            project.contents.count(by: \.type.rawValue)
        }

        func contentThemeCounts(in project: Project) -> [String: Int] {
            project.contents.lazy
                .flatMap(\.themes)
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
