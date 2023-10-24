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
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
