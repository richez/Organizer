//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct ContentView: View {
    var contents: [ProjectContent]
    var placeholders: Int

    @State private var viewModel: ViewModel
    @Environment(\.widgetFamily) private var widgetFamily

    init(project: Project, contents: [ProjectContent], placeholders: Int) {
        self._viewModel = State(initialValue: ViewModel(project: project))
        self.contents = contents
        self.placeholders = placeholders
    }

    var body: some View {
        ContentContainerView(systemImage: "ellipsis") {
            self.projectStack {
                Text(self.viewModel.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(1)

                Text(self.viewModel.themes)
                    .font(.system(size: 9))
                    .foregroundStyle(.cellSubtitle)
                    .lineLimit(1)
            }

            if self.widgetFamily == .systemLarge {
                Spacer()
            }

            ContentListView(contents: self.contents, placeholders: self.placeholders)
        }
        .widgetURL(.project(id: self.viewModel.projectID))
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
}
