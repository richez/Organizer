//
//  ProjectListPreviewStyleMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectListPreviewStyleMenu: View {
    @AppStorage(.projectListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.projectListShowStatistics)
    private var showStatistics: Bool = true

    var body: some View {
        Menu("Preview Style", systemImage: "text.alignleft") {
            Toggle("Theme", isOn: self.$showTheme)
            Toggle("Statistics", isOn: self.$showStatistics)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ProjectListPreviewStyleMenu()
    }
}
