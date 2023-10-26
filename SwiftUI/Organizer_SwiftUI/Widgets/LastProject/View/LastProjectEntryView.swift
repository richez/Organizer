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
        VStack(alignment: .leading) {

            if let project = self.entry.project {
                ProjectView(project: project)
            } else {
                self.emptyView
            }

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundStyle(.launchscreenBackground)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}

private extension LastProjectEntryView {
    var emptyView: some View {
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
