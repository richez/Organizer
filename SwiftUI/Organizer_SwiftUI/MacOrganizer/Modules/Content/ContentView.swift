//
//  ContentView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project
    @Binding var selected: ProjectContent?

    var body: some View {
        VStack(alignment: .leading) {
            ContentHeaderView(project: self.project)

            Divider()
                .foregroundStyle(.black)

            ContentListContainerView(project: self.project, selected: self.$selected)
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentView(project: PreviewDataGenerator.project, selected: .constant(nil))
                .background(.listBackground)
        }
    }
}
