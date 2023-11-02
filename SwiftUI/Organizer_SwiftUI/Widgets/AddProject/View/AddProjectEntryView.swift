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
                AddProjectCircularView()
            #endif
            default:
                AddProjectView()
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
        .widgetURL(Deeplink.projectForm.url)
    }
}
