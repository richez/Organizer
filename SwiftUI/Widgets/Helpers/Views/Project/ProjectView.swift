//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 27/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @State private var viewModel: ViewModel
    @Environment(\.widgetFamily) private var widgetFamily

    init(project: Project) {
        self._viewModel = State(initialValue: ViewModel(project: project))
    }

    var body: some View {
        Group {
            switch self.widgetFamily {
            #if !os(macOS)
            case .accessoryCircular:
                CircularView(systemImage: "doc.text.magnifyingglass")
            case .accessoryRectangular:
                RectangularView(title: self.viewModel.title, subtitle: self.viewModel.themes)
            #endif
            default:
                self.defaultView
            }
        }
        .widgetURL(.project(id: self.viewModel.projectID))
    }
}

private extension ProjectView {
    var defaultView: some View {
        ContentContainerView(systemImage: "ellipsis") {
            VStack(alignment: .leading, spacing: 12) {
                Text(self.viewModel.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(2)

                Group {
                    Text(self.viewModel.themes)
                        .lineLimit(1)
                    Text(self.viewModel.statistics)
                        .lineLimit(2)
                }
                .font(.system(size: 12))
                .foregroundStyle(.cellSubtitle)
            }
        }
    }
}
