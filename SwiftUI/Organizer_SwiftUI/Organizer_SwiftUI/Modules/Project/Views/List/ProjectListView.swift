//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    @Binding var selected: Project?

    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Query private var projects: [Project]

    @State private var editingProject: Project?

    init(selected: Binding<Project?>,
         predicate: Predicate<Project>?,
         sort: SortDescriptor<Project>
    ) {
        self._selected = selected
        self._projects = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        List(selection: self.$selected) {
            ForEach(self.projects, id: \.self) { project in
                ProjectRow(project: project)
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
                    #if !os(macOS)
                    .swipeActions {
                        SwipeActionButton(.delete) {
                            self.viewModel.delete(project, in: self.modelContext)
                        }
                        SwipeActionButton(.edit) {
                            self.editingProject = project
                        }
                    }
                    #endif
            }
        }
        .sheet(item: self.$editingProject) { project in
            ProjectForm(project: project)
        }
        #if !os(macOS)
        .toolbar {
            ToolbarItem {
                ProjectListMenu(
                    projectCount: self.projects.count,
                    themes: self.viewModel.themes(in: self.modelContext)
                )
            }
        }
        #endif
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectListView(
                selected: .constant(nil),
                predicate: nil,
                sort: SortDescriptor(\.updatedDate, order: .reverse)
            )
            .listStyle()
        }
    }
}
