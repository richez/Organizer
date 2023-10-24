//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    @FocusedValue(\.selectedProject) private var selectedProject
    @FocusedBinding(\.isShowingProjectForm) private var isShowingProjectForm

    @Environment(\.modelContext) private var modelContext

    private let store: ProjectStoreReader = ProjectStore.shared

    var body: some View {
        NavigationView()
            .navigationSplitViewStyle(.balanced)
            .background(.listBackground)
            .handlesExternalEvents(preferring: ["*"], allowing: ["*"])
            .onOpenURL { url in
                self.handleIncomingURL(url)
            }
    }
}

private extension MainView {
    func handleIncomingURL(_ url: URL) {
        guard let deeplink = Deeplink(url: url) else {
            print("Unsupported url: \(url)")
            return
        }

        switch deeplink {
        case .projectForm:
            self.showProjectForm()
        case .project(let id):
            self.showProject(with: id)
        default:
            break
        }
    }

    func showProjectForm() {
        withAnimation {
            self.selectedProject?.wrappedValue = nil
            self.isShowingProjectForm = true
        }
    }

    func showProject(with identifier: String) {
        guard 
            let uuid = UUID(uuidString: identifier),
            let project = self.store.project(for: uuid, in: self.modelContext)
        else {
            print("Could not find a a project with id: \(identifier)")
            return
        }

        withAnimation {
            self.selectedProject?.wrappedValue = project
        }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
