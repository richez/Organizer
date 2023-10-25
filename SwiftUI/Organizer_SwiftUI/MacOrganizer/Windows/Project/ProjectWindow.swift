//
//  ProjectWindow.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectWindow: View {
    @Binding var projectID: PersistentIdentifier?

    private let store: ProjectStoreReader = ProjectStore.shared

    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL

    var body: some View {
        Group {
            if let project {
                ContentView(project: project)
            } else {
                ProjectUnavailableView()
            }
        }
        .background(.listBackground)
        .onChange(of: self.navigationContext.selectedContent) {
            if let content = self.navigationContext.selectedContent {
                self.openURL(content.url)
                self.navigationContext.selectedContent = nil
            }
        }
    }
}

private extension ProjectWindow {
    var project: Project? {
        guard let projectID else { return nil }
        return self.store.project(with: projectID, in: self.modelContext)
    }
}

#Preview("Content") {
    ModelContainerPreview {
        ProjectWindow(projectID: .constant(PreviewDataGenerator.project.persistentModelID))
    }
}

#Preview("No Content") {
    ModelContainerPreview {
        ProjectWindow(projectID: .constant(nil))
    }
}
