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

    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL

    @Query private var contents: [ProjectContent]
    @State private var editingContent: ProjectContent?

    init(project: Project,
         predicate: Predicate<ProjectContent>?,
         sort: SortDescriptor<ProjectContent>) {
        self.project = project
        self._contents = Query(filter: predicate, sort: [sort], animation: .default)
    }

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        List(selection: $navigationContext.selectedContent) {
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
                            self.viewModel.delete(content, in: self.modelContext)
                            self.navigationContext.selectedContent = nil
                        }
                    }
                    #if !os(macOS)
                    .swipeActions {
                        SwipeActionButton(.delete) {
                            self.viewModel.delete(content, in: self.modelContext)
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
                    themes: self.viewModel.themes(in: self.project),
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
                predicate: nil,
                sort: SortDescriptor(\.updatedDate)
            )
            .listStyle()
        }
    }
}
