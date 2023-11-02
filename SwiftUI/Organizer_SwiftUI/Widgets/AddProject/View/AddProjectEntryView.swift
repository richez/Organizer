//
//  AddProjectEntryView.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

struct AddProjectEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        Group {
            switch self.widgetFamily {
            #if !os(macOS)
            case .accessoryCircular:
                CircularView(systemImage: "square.and.pencil")
            #endif
            default:
                self.defaultView
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
        .widgetURL(Deeplink.projectForm.url)
    }
}

private extension AddProjectEntryView {
    var defaultView: some View {
        ContentContainerView(systemImage: "plus") {
            Text("New Project")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.cellTitle)

            Spacer()

            VStack(alignment: .leading) {
                ForEach([70, 90, 80, 50], id: \.self) { width in
                    Capsule()
                        .fill(.cellSeparatorTint)
                        .frame(width: width)
                }
            }
            .redacted(reason: .placeholder)
        }
    }
}
