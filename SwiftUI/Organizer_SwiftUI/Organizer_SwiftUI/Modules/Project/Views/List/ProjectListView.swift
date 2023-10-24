//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    private let store: ProjectStoreOperations = ProjectStore.shared

    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query private var projects: [Project]

    init(predicate: Predicate<Project>?, sort: SortDescriptor<Project>) {
        self._projects = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        List(selection: $navigationContext.selectedProject) {
            ForEach(self.projects, id: \.self) { project in
                ProjectRow(project: project, isSelected: project == navigationContext.selectedProject)
                    .listRowBackground(Color.listBackground)
                    .listRowSeparatorTint(.cellSeparatorTint)
                    .contextMenu {
                        ContextMenuButton(.duplicate) {
                            self.store.duplicate(project, in: self.modelContext)
                        }
                        ContextMenuButton(.edit) {
                            self.navigationContext.isEditingProject = project
                        }
                        ContextMenuButton(.delete) {
                            self.store.delete(project, in: self.modelContext)
                            self.navigationContext.selectedProject = nil
                        }
                    }
                    #if !os(macOS)
                    .swipeActions {
                        SwipeActionButton(.delete) {
                            self.store.delete(project, in: self.modelContext)
                        }
                        SwipeActionButton(.edit) {
                            self.navigationContext.isEditingProject = project
                        }
                    }
                    #endif
            }
        }
        .sheet(item: $navigationContext.isEditingProject) { project in
            ProjectForm(project: project)
        }
        #if !os(macOS)
        .toolbar {
            ToolbarItem {
                ProjectListMenu(
                    projectCount: self.projects.count,
                    themes: self.store.themes(in: self.modelContext)
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
                predicate: nil,
                sort: SortDescriptor(\.updatedDate, order: .reverse)
            )
            .listStyle()
        }
    }
}
