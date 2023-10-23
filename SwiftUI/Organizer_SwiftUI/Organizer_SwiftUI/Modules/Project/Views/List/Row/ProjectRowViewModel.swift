//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        func themes(for themes: [String]) -> String {
            themes.map { "#\($0)" }.joined(separator: " ")
        }

        func statistics(for contents: [ProjectContent]) -> String {
            let contentCount = contents.count
            guard contentCount > 0 else { return "" }

            let contentTypeCounts = contents
                .count(by: \.type)
                .sorted { $0.key.rawValue < $1.key.rawValue }
                .map { "\($0.value) \($0.key)s" }
                .joined(separator: ", ")

            return "\(contentCount) contents (\(contentTypeCounts))"
        }

        func updatedDate(for updatedDate: Date) -> String {
            let format: Date.FormatStyle = .dateTime
                .day()
                .month(.abbreviated)
            return updatedDate.formatted(format)
        }
    }
}
