//
//  ContentRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentRow {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let content: ProjectContent
        private let formatter: ContentFormatterProtocol

        // MARK: - Initialization

        init(content: ProjectContent, formatter: ContentFormatterProtocol = ContentFormatter()) {
            self.content = content
            self.formatter = formatter
        }

        // MARK: - Public

        var systemImage: String {
            self.content.type.systemImage
        }

        var title: String {
            self.content.title
        }

        var themes: String {
            self.formatter.themes(from: self.content.theme)
        }
    }
}
