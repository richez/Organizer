//
//  ContentView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project

    var body: some View {
        ContentListContainerView(project: self.project)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentView(project: PreviewDataGenerator.project)
        }
    }
}

struct ContentRow: View {
    var content: ProjectContent

    init(content: ProjectContent, suiteName: String) {
        self.content = content
    }

    var body: some View {
        Text(self.content.title)
            .foregroundStyle(.white)
    }
}

struct ContentForm: View {
    var project: Project
    var content: ProjectContent?

    var body: some View {
        Text("Content Form")
    }
}
