//
//  ContentViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentView {
    struct ViewModel {
        func navbarSubtitle(
            selectedTheme: String?,
            selectedType: ProjectContentType?
        ) -> String {
            switch (selectedTheme, selectedType) {
            case (.none, .none):
                return ""
            case (.none, .some(let selectedType)):
                return "\(selectedType.rawValue)s"
            case (.some(let selectedTheme), .none):
                return "#\(selectedTheme)"
            case (.some(let selectedTheme), .some(let selectedType)):
                return "#\(selectedTheme) - \(selectedType.rawValue)s"
            }
        }
    }
}
