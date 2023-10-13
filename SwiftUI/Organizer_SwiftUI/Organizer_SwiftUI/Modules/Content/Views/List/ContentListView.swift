//
//  ContentListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftData
import SwiftUI

struct ContentListView: View {
    var project: Project

    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Query private var contents: [ProjectContent]

    init(project: Project,
         predicate: Predicate<ProjectContent>?,
         sort: SortDescriptor<ProjectContent>) {
        self.project = project
        self._contents = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        List {
            ForEach(self.contents) { content in
                ContentRow(
                    content: content, suiteName: self.project.suiteName
                )
                .listRowBackground(Color.listBackground)
                .listRowSeparatorTint(.cellSeparatorTint)
            }
        }
        .toolbar {
            ToolbarItem {
                ContentListMenu(
                    contentCount: self.contents.count,
                    themes: self.viewModel.themes(
                        in: self.project, context: self.modelContext
                    ),
                    suiteName: self.project.suiteName
                )
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentListView(
                project: PreviewDataGenerator.project,
                predicate: nil,
                sort: SortDescriptor(\.updatedDate)
            )
            .listStyle()
        }
    }
}
