//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        VStack {
            ProjectHeaderView()
            ProjectListContainerView()
        }
        .background(.listBackground)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView()
        }
    }
}


// MARK: - Placeholders

struct ContentView: View {
    var project: Project

    var body: some View {
        Text(self.project.title)
    }
}

struct ProjectRow: View {
    var project: Project

    var body: some View {
        Text(self.project.title)
    }
}

struct ProjectForm: View {
    var project: Project?

    var body: some View {
        Text("Bonjour")
    }
}
