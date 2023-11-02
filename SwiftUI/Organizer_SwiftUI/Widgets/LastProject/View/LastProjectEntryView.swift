//
//  LastProjectEntryView.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

struct LastProjectEntryView: View {
    var entry: LastProjectEntry

    var body: some View {
        Group {
            if let project = self.entry.project {
                ProjectView(project: project)
            } else {
                EmptyProjectView()
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}
