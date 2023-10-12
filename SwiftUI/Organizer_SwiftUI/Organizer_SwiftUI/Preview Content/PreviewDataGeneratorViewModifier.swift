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
                self.generateData()
            }
    }

    private func generateData() {
        Project.sample.forEach { project in
            self.modelContext.insert(project)
        }
    }
}

extension View {
    func generatePreviewData() -> some View {
        self.modifier(PreviewDataGeneratorViewModifier())
    }
}

extension Project {
    static var sample: [Project] {
        [
            Project(
                title: "Self-Build",
                theme: "DIY",
                contents: [
                    ProjectContent(
                        type: .article, title: "How to choose your insulation materials ?", theme: "insulation"
                    ),
                    ProjectContent(type: .video, title: "The type of screws you should know", theme: "tools")
                ]
            ),
            Project(
                title: "Hiking",
                theme: "Sport, Outdoor",
                contents: [
                    ProjectContent(type: .note, title: "The best hiking spots", theme: "spots"),
                    ProjectContent(type: .article, title: "The best backpack gear list", theme: "gear")
                ]
            )
        ]
    }
}
