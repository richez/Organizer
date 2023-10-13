//
//  PreviewDataGeneratorViewModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct PreviewDataGeneratorViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext

    func body(content: Content) -> some View {
        content
            .onAppear {
                PreviewDataGenerator.generateData(in: self.modelContext)
            }
    }
}

extension View {
    func generatePreviewData() -> some View {
        self.modifier(PreviewDataGeneratorViewModifier())
    }
}
