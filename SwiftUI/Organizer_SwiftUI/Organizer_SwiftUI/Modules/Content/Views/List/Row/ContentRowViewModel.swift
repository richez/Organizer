//
//  ContentRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentRow {
    struct ViewModel {
        func imageSystemName(for type: ProjectContentType) -> String {
            switch type {
            case .article:
                return "newspaper"
            case .note:
                return "note"
            case .video:
                return "video"
            case .other:
                return "questionmark.square"
            }
        }

        func themes(for themes: [String]) -> String {
            themes.lazy.map { "#\($0)" }.joined(separator: " ")
        }
    }
}
