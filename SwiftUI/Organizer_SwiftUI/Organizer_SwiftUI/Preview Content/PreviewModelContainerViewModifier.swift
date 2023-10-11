//
//  PreviewModelContainerViewModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct PreviewModelContainerViewModifier: ViewModifier {
    let container: ModelContainer

    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        self.container = try! ModelContainer(for: Project.self, ProjectContent.self, configurations: config)
    }

    func body(content: Content) -> some View {
        content
            .generatePreviewData()
            .modelContainer(self.container)
    }
}

extension View {
    func previewModelContainer() -> some View {
        self.modifier(PreviewModelContainerViewModifier())
    }
}
