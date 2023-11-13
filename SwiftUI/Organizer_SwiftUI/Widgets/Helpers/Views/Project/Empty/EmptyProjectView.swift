//
//  EmptyProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct EmptyProjectView: View {
    var kind: Kind = .default

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        Group {
            switch self.widgetFamily {
            #if !os(macOS)
            case .accessoryCircular:
                CircularView(systemImage: "doc.text.magnifyingglass")
            case .accessoryRectangular:
                RectangularView(title: self.kind.shortText, subtitle: "#theme")
            #endif
            default:
                self.defaultView
            }
        }
        .widgetURL(.projectForm)
    }
}

private extension EmptyProjectView {
    var defaultView: some View {
        ContentContainerView(systemImage: "ellipsis") {
            Group {
                Image(.launchscreenLogo)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.cellSubtitle)
                    .frame(width: 60, height: 60)

                Text(self.kind.text)
                    .font(.system(size: 10, weight: .light))
                    .foregroundStyle(.cellSubtitle)
                    .multilineTextAlignment(.center)
            }
            .padding([.leading, .trailing])
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

extension EmptyProjectView {
    enum Kind {
        case `default`
        case projects
        case singleProject

        var shortText: String {
            switch self {
            case .default: "Create project"
            case .projects: "Select theme"
            case .singleProject: "Select project"
            }
        }

        var text: String {
            switch self {
            case .default: "Tap and create your first project"
            case .projects: "Tap and hold to choose a theme"
            case .singleProject: "Tap and hold to choose a project"
            }
        }
    }
}
