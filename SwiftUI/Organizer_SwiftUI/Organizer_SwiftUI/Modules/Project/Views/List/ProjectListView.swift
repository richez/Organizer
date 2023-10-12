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

    init(predicate: Predicate<Project>?, sort: SortDescriptor<Project>) {
        self._projects = Query(filter: predicate, sort: [sort])
    }

    var body: some View {
        List {
            ForEach(self.projects) { project in
                ProjectRow(project: project)
                    .listRowBackground(Color.listBackground)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(self.viewModel.navbarTitle)
            }

            ToolbarItem {
                ProjectListMenu(
                    projectCount: self.projects.count,
                    themes: self.viewModel.themes(in: self.modelContext)
                )
            }
        }
        .foregroundStyle(.navbarContent)
        .tint(.navbarContent)
    }
}

#Preview {
    NavigationStack {
        ProjectListView(predicate: nil, sort: SortDescriptor(\.updatedDate))
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
    }
    .previewModelContainer()
}
