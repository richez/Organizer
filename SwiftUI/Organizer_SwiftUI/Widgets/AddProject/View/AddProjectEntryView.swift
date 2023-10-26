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
                self.circularView
            #endif
            default:
                self.defaultView
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}

private extension AddProjectEntryView {
    var circularView: some View {
        Image(systemName: "square.and.pencil")
            .font(.system(size: 17, weight: .bold))
            .padding(10)
            .background(.floatingButton)
            .clipShape(.circle)
    }

    var defaultView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("New Project")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.cellTitle)

            Spacer()

            VStack(alignment: .leading) {
                ForEach([70, 90, 80, 50], id: \.self) { width in
                    Capsule()
                        .frame(width: width)
                }
            }
            .foregroundStyle(.placeholder)
            .redacted(reason: .placeholder)

            Spacer()

            Image(systemName: "plus")
                .foregroundStyle(.launchscreenBackground)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
