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
    @Binding var selected: ProjectContent?

    private let store: ContentStoreOperations = ContentStore.shared

    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL
    @Query private var contents: [ProjectContent]

    @State private var editingContent: ProjectContent?

    init(project: Project,
         selected: Binding<ProjectContent?>,
         predicate: Predicate<ProjectContent>?,
         sort: SortDescriptor<ProjectContent>) {
        self.project = project
        self._selected = selected
        self._contents = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        List(selection: self.$selected) {
            ForEach(self.contents, id: \.self) { content in
                ContentRow(content: content, suiteName: self.project.identifier.uuidString)
                    .listRowBackground(Color.listBackground)
                    .listRowSeparatorTint(.cellSeparatorTint)
                    .contextMenu {
                        ContextMenuButton(.openBrowser) {
                            self.openURL(content.url)
                        }
                        ContextMenuButton(.copyLink) {
                            Pasteboard.general.set(content.url)
                        }
                        ContextMenuButton(.edit) {
                            self.editingContent = content
                        }
                        ContextMenuButton(.delete) {
                            self.store.delete(content, in: self.modelContext)
                        }
                    }
                    #if !os(macOS)
                    .swipeActions {
                        SwipeActionButton(.delete) {
                            self.store.delete(content, in: self.modelContext)
                        }
                        SwipeActionButton(.edit) {
                            self.editingContent = content
                        }
                    }
                    #endif
            }
        }
        .sheet(item: self.$editingContent) { content in
            ContentForm(project: self.project, content: content)
        }
        #if !os(macOS)
        .toolbar {
            ToolbarItem {
                ContentListMenu(
                    contentCount: self.contents.count,
                    themes: self.store.themes(in: self.project),
                    suiteName: self.project.identifier.uuidString
                )
            }
        }
        #endif
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentListView(
                project: PreviewDataGenerator.project,
                selected: .constant(nil),
                predicate: nil,
                sort: SortDescriptor(\.updatedDate)
            )
            .listStyle()
        }
    }
}
