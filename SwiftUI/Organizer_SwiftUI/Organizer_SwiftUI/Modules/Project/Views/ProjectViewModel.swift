//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectView {
    struct ViewModel {
        var store: ProjectStoreDescriptor = ProjectStore()

        var navbarTitle: String { "Projects" }

        func navbarSubtitle(for selectedTheme: String?) -> String {
            self.store.themeDescription(for: selectedTheme)
        }
    }
}
