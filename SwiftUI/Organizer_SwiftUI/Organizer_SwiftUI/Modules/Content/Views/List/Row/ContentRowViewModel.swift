//
//  ContentRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentRow {
    struct ViewModel {
        func imageSystemName(of content: ProjectContent) -> String {
            switch content.type {
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

        func title(of content: ProjectContent) -> String {
            content.title
        }

        func themes(of content: ProjectContent) -> String {
            content.themes.map { "#\($0)" }.joined(separator: " ")
        }
    }
}
