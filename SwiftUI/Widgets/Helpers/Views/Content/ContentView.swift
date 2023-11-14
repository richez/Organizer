//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project
    var contents: [ProjectContent]
    var placeholders: Int

    private let viewModel = ViewModel()

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        ContentContainerView(systemImage: "ellipsis") {
            self.projectStack {
                Text(self.project.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(1)

                Text(self.themes)
                    .font(.system(size: 9))
                    .foregroundStyle(.cellSubtitle)
                    .lineLimit(1)
            }

            if self.widgetFamily == .systemLarge {
                Spacer()
            }

            ContentListView(contents: self.contents, placeholders: self.placeholders)
        }
        .widgetURL(.project(id: self.projectID))
    }
}

private extension ContentView {
    @ViewBuilder
    func projectStack<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        switch self.widgetFamily {
        case .systemMedium:
            HStack(spacing: 8) { content() }
        default:
            VStack(alignment: .leading, spacing: 8) { content() }
        }
    }


    var themes: String {
        self.viewModel.themes(from: self.project.theme)
    }

    var projectID: String {
        self.project.identifier.uuidString
    }
}
