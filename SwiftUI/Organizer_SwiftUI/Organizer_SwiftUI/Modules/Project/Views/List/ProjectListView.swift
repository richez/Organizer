//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Query private var projects: [Project]

    @State private var editingProject: Project?

    init(predicate: Predicate<Project>?, sort: SortDescriptor<Project>) {
        self._projects = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        List {
            ForEach(self.projects) { project in
                NavigationLink {
                    ContentView(project: project)
                } label: {
                    ProjectRow(project: project)
                }
                .listRowBackground(Color.listBackground)
                .swipeActions {
                    SwipeActionButton(.delete) {
                        self.viewModel.delete(project, from: self.modelContext)
                    }
                    SwipeActionButton(.edit) {
                        self.editingProject = project
                    }
                }
            }
        }
        .sheet(item: self.$editingProject) { project in
            ProjectForm(project: project)
        }
        .toolbar {
            ToolbarItem {
                ProjectListMenu(
                    projectCount: self.projects.count,
                    themes: self.viewModel.themes(in: self.modelContext)
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProjectListView(predicate: nil, sort: SortDescriptor(\.updatedDate, order: .reverse))
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
    }
    .previewModelContainer()
}
