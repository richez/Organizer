//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @FocusedValue(\.selectedProject) private var selectedProject
    @FocusedBinding(\.isShowingProjectForm) private var isShowingProjectForm
    @FocusedValue(\.selectedContent) private var selectedContent

    @Environment(\.modelContext) private var modelContext

    private let deeplinkManager: DeeplinkManager = .init()

    var body: some View {
        NavigationView()
            .navigationSplitViewStyle(.balanced)
            .background(.listBackground)
            .handlesExternalEvents(preferring: ["*"], allowing: ["*"])
            .onOpenURL { url in
                do {
                    try self.handleIncomingURL(url)
                } catch {
                    print("Could not handle url (\(url)): \(error)")
                }
            }
    }
}

private extension MainView {
    func handleIncomingURL(_ url: URL) throws {
        let deeplinkTarget = try self.deeplinkManager.target(for: url, context: self.modelContext)

        switch deeplinkTarget {
        case .projectForm:
            withAnimation {
                self.selectedContent?.wrappedValue = nil
                self.selectedProject?.wrappedValue = nil
                self.isShowingProjectForm = true
            }

        case .project(let project):
            withAnimation {
                self.selectedContent?.wrappedValue = nil
                self.selectedProject?.wrappedValue = project
            }

        case .content(let content, let project):
            withAnimation {
                self.selectedContent?.wrappedValue = nil
                self.selectedProject?.wrappedValue = project
            } completion: {
                self.selectedContent?.wrappedValue = content
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
