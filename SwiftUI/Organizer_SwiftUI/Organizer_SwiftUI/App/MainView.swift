//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

// @State object created in the app first view are shared
// between windows. Thus, this type is used to force SwiftUI
// to create a new NavigationContext for each window.
struct MainContainerView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    @State private var navigationContext: NavigationContext = .init()
    @Environment(\.modelContext) private var modelContext

    private let deeplinkManager: DeeplinkManager = .init()

    var body: some View {
        NavigationView()
            .navigationSplitViewStyle(.balanced)
            .background(.listBackground)
            .environment(self.navigationContext)
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
        #if os(iOS)
        let delay: DispatchTime = .now() + 1
        #else
        let delay: DispatchTime = .now()
        #endif

        switch deeplinkTarget {
        case .projectForm:
            withAnimation {
                self.navigationContext.selectedContent = nil
                self.navigationContext.selectedProject = nil
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self.navigationContext.isShowingProjectForm = true
                }
            }

        case .project(let project):
            withAnimation {
                self.navigationContext.selectedContent = nil
                self.navigationContext.selectedProject = project
            }

        case .content(let content, let project):
            withAnimation {
                self.navigationContext.selectedContent = nil
                self.navigationContext.selectedProject = project
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self.navigationContext.selectedContent = content
                }
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
