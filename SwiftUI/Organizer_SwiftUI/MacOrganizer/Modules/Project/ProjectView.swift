//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @Binding var selected: Project?

    var body: some View {
        VStack {
            ProjectHeaderView()
            ProjectListContainerView(selected: self.$selected)
        }
        .background(.listBackground)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView(selected: .constant(nil))
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
