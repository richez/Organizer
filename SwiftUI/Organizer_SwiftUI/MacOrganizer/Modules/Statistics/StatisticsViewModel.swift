//
//  StatisticsViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension StatisticsView {
    struct ViewModel {
        // TODO: update logic to select content type
        func maxContentType(in project: Project) -> (name: String, count: Int)? {
            let contentTypes = project.contents.reduce(into: [:]) { result, content in
                result[content.type.rawValue, default: 0] += 1
            }
            let sorted = contentTypes.sorted { $0.key < $1.key }
            guard let maxType = sorted.max(by: { $0.value < $1.value }) else {
                return nil
            }

            return (maxType.key, maxType.value)
        }

        // TODO: update logic to select content theme
        func maxContentTheme(in project: Project) -> (name: String, count: Int)? {
            let contentThemes = project.contents.reduce(into: [:]) { result, content in
                content.themes.forEach { result[$0, default: 0] += 1 }
            }
            let sorted = contentThemes.sorted { $0.key < $1.key }
            guard let maxTheme = sorted.max(by: { $0.value < $1.value }) else {
                return nil
            }

            return (maxTheme.key, maxTheme.value)
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
