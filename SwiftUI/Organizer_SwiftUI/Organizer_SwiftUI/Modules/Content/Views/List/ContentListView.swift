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
    @Environment(\.openURL) private var openURL
    @Query private var contents: [ProjectContent]

    @State private var editingContent: ProjectContent?
    @State private var isShowingURLError: Bool = false

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
                .contextMenu {
                    ContextMenuButton(.openBrowser) {
                        self.url(for: content) { url in
                            self.openURL(url)
                        }
                    }
                    ContextMenuButton(.copyLink) {
                        self.url(for: content) { url in
                            UIPasteboard.general.url = url
                        }
                    }
                    ContextMenuButton(.edit) {
                        self.editingContent = content
                    }
                    ContextMenuButton(.delete) {
                        self.viewModel.delete(content, in: self.modelContext)
                    }
                }
                .swipeActions {
                    SwipeActionButton(.delete) {
                        self.viewModel.delete(content, in: self.modelContext)
                    }
                    SwipeActionButton(.edit) {
                        self.editingContent = content
                    }
                }
            }
        }
        .sheet(item: self.$editingContent) { content in
            ContentForm(project: self.project, content: content)
        }
        .alert("The content link is not valid", isPresented: self.$isShowingURLError) {
        } message: {
            Text("Edit link and try again")
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

private extension ContentListView {
    func url(for content: ProjectContent, action: (URL) -> Void) {
        do {
            let url = try self.viewModel.url(for: content)
            action(url)
        } catch {
            print("Could not retrieve content url: \(error)")
            self.isShowingURLError = true
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
