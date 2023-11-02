//
//  EmptyProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct EmptyProjectView: View {
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        Group {
            switch self.widgetFamily {
            #if !os(macOS)
            case .accessoryCircular:
                CircularView(systemImage: "doc.text.magnifyingglass")
            case .accessoryRectangular:
                RectangularView(title: "Create a project", subtitle: "#theme")
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

                Text("Tap and create your first project")
                    .font(.system(size: 10, weight: .light))
                    .foregroundStyle(.cellSubtitle)
                    .multilineTextAlignment(.center)
            }
            .padding([.leading, .trailing])
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
