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
                ],
                updatedDate: .now
            ),
            Project(
                title: "Hiking",
                theme: "Sport, Outdoor",
                contents: [
                    ProjectContent(type: .note, title: "The best hiking spots", theme: "spots"),
                    ProjectContent(type: .article, title: "The best backpack gear list", theme: "gear")
                ],
                updatedDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!
            ),
            Project(
                title: "Bicycle",
                theme: "Sport, Outdoor",
                contents: [
                    ProjectContent(type: .other, title: "The best cycling spots", theme: "spots"),
                    ProjectContent(type: .video, title: "The best backpack gear list", theme: "gear")
                ],
                updatedDate: Calendar.current.date(byAdding: .day, value: -2, to: .now)!
            ),
            Project(
                title: "Jobs",
                theme: "",
                contents: [],
                updatedDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)!
            )
        ]
    }
}
