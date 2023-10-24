//
//  ModelContainerPreview.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ModelContainerPreview<Content: View>: View {
    var content: () -> Content
    let container: ModelContainer

    init(_ modelContainer: @escaping () throws -> ModelContainer = ModelContainer.preview,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        do {
            self.container = try MainActor.assumeIsolated(modelContainer)
        } catch {
            fatalError("Failed to create the model container: \(error.localizedDescription)")
        }
    }

    var body: some View {
        self.content()
            .modelContainer(container)
    }
}
