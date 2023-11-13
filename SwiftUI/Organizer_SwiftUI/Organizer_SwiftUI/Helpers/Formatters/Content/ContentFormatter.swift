//
//  ContentFormatter.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

struct ContentFormatter {
}

// MARK: - ContentFormatterProtocol

extension ContentFormatter: ContentFormatterProtocol {
    // MARK: Content

    func content(from values: ContentValues) -> ProjectContent {
        .init(
            type: values.type,
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            url: values.url
        )
    }

    // MARK: Values

    func values(type: ProjectContentType, url: URL, title: String, theme: String) -> ContentValues {
        .init(
            type: type,
            url: url,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: theme.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    // MARK: Themes

    func themes(from contents: [ProjectContent]) -> [String] {
        contents.lazy
            .flatMap(\.theme.words)
            .removingDuplicates()
            .sorted(using: .localizedStandard)
    }

    func themes(from string: String) -> String {
        string.words.lazy.map { "#\($0)" }.joined(separator: " ")
    }

    func filtersDescription(from selectedTheme: String?, selectedType: ProjectContentType?) -> String {
        switch (selectedTheme, selectedType) {
        case (.none, .none): ""
        case (.none, .some(let selectedType)): "\(selectedType.name)s"
        case (.some(let selectedTheme), .none): "#\(selectedTheme)"
        case (.some(let selectedTheme), .some(let selectedType)): "#\(selectedTheme) - \(selectedType.name)s"
        }
    }
}
