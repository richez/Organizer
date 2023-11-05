//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import OSLog
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
    @State private var deeplinkError: Error?
    @Environment(\.modelContext) private var modelContext

    private let deeplinkManager: DeeplinkManager = .init()

    var body: some View {
        NavigationView()
            .navigationSplitViewStyle(.balanced)
            .background(.listBackground)
            .environment(self.navigationContext)
            // Received URL will be handled by the current window instead of opening a new one (macOS, iPadOS)
            .handlesExternalEvents(preferring: ["*"], allowing: ["*"])
            .onOpenURL { url in
                do {
                    try self.handleIncomingURL(url)
                    Logger.deeplinks.info("Did handle url \(url)")
                } catch {
                    Logger.deeplinks.info("Fail to handle url \(url): \(error)")
                    self.deeplinkError = error
                }
            }
            .errorAlert(self.$deeplinkError)
    }
}

private extension MainView {
    // We need to add a delay before performing some actions on iOS to
    // make sure the associated view is displayed after navigation changes.
    // On macOS, the views are always displayed so we don't need to wait.
    var actionDelay: DispatchTime {
        #if os(iOS)
        return .now() + 1
        #else
        return .now()
        #endif
    }

    func handleIncomingURL(_ url: URL) throws {
        let deeplinkTarget = try self.deeplinkManager.target(for: url, context: self.modelContext)

        switch deeplinkTarget {
        case .home:
            withAnimation {
                self.navigationContext.selectedContent = nil
                self.navigationContext.selectedProject = nil
            }
        case .projectForm:
            withAnimation {
                self.navigationContext.selectedContent = nil
                self.navigationContext.selectedProject = nil
                DispatchQueue.main.asyncAfter(deadline: self.actionDelay) {
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
                DispatchQueue.main.asyncAfter(deadline: self.actionDelay) {
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
