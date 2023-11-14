//
//  ProjectFormatter.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import Foundation

struct ProjectFormatter {
}

// MARK: - ProjectFormatterProtocol

extension ProjectFormatter: ProjectFormatterProtocol {
    // MARK: Project

    func project(from values: ProjectValues) -> Project {
        .init(
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    // MARK: Values

    func values(title: String, theme: String) -> ProjectValues {
        .init(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: theme.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    // MARK: Themes

    func themes(from projects: [Project]) -> [String] {
        projects.lazy
            .flatMap(\.theme.words)
            .removingDuplicates()
            .sorted(using: .localizedStandard)
    }

    func themes(from string: String) -> String {
        string.words.lazy.map { "#\($0)" }.joined(separator: " ")
    }

    func filterDescription(from selectedTheme: String?) -> String {
        switch selectedTheme {
        case .none: ""
        case .some(let theme): "#\(theme)"
        }
    }

    // MARK: Statistics

    /// Returns a String representation of the ``ProjectContent`` in a project.
    /// (Ex: "4 contents (2 articles, 4 notes, 1 video)")
    func statistics(from contents: [ProjectContent]) -> String {
        let contentCount = contents.count
        guard contentCount > 0 else { return "" }

        let contentTypeCounts = contents.lazy
            .count(by: \.type)
            .sorted { $0.key.rawValue < $1.key.rawValue }
            .map { String(localized: "\($0.value) \($0.key.name)", comment: "Number of content type") }
            .joined(separator: ", ")

        return String(localized: "\(contentCount) contents") + " (\(contentTypeCounts))"
    }

    // MARK: Date

    /// Returns string representation of a date using the specified date format style.
    ///
    /// - Parameters:
    ///   - date: The date to format.
    ///   - format: The date format style to apply to the date (e.g. '14 Nov' for
    ///   ``DateFormat/abbreviated`` or '14 Nov 2023 at 11:41' for ``DateFormat/full``).
    func string(from date: Date, format: DateFormat) -> String {
        date.formatted(format.style)
    }
}

extension ProjectFormatter {
    enum DateFormat {
        case full
        case abbreviated

        fileprivate var style: Date.FormatStyle {
            switch self {
            case .full: .dateTime
                    .day(.defaultDigits)
                    .month(.abbreviated)
                    .year(.defaultDigits)
                    .hour(.conversationalTwoDigits(amPM: .wide))
                    .minute(.twoDigits)
            case .abbreviated: .dateTime
                    .day()
                    .month(.abbreviated)
            }
        }
    }
}
