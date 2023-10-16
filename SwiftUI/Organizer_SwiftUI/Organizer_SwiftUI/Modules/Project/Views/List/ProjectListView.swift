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
                .listRowSeparatorTint(.cellSeparatorTint)
                .contextMenu {
                    ContextMenuButton(.duplicate) {
                        self.viewModel.duplicate(project, in: self.modelContext)
                    }
                    ContextMenuButton(.edit) {
                        self.editingProject = project
                    }
                    ContextMenuButton(.delete) {
                        self.viewModel.delete(project, in: self.modelContext)
                    }
                }
                .swipeActions {
                    SwipeActionButton(.delete) {
                        self.viewModel.delete(project, in: self.modelContext)
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
    ModelContainerPreview {
        NavigationStack {
            ProjectListView(predicate: nil, sort: SortDescriptor(\.updatedDate, order: .reverse))
                .listStyle()
        }
    }
}
