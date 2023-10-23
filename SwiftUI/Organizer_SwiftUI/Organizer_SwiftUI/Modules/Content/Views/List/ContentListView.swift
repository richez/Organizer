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

    private let store: ContentStoreOperations = ContentStore.shared

    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL
    @Query private var contents: [ProjectContent]

    @State private var isShowingContentURL: URL?
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
                Button {
                    self.url(for: content) { url in
                        self.isShowingContentURL = url
                    }
                } label: {
                    ContentRow(
                        content: content, suiteName: self.project.identifier.uuidString
                    )
                }
                .buttonStyle(.borderless)
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
                            Pasteboard.general.set(url)
                        }
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
        .alert(.invalidContentLink, isPresented: self.$isShowingURLError)
        #if os(macOS)
        .onChange(of: self.isShowingContentURL) {
            if let url = self.isShowingContentURL {
                self.openURL(url)
                self.isShowingContentURL = nil
            }
        }
        #else
        .fullScreenCover(item: self.$isShowingContentURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
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

private extension ContentListView {
    func url(for content: ProjectContent, action: (URL) -> Void) {
        do {
            let url = try self.store.url(for: content)
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
