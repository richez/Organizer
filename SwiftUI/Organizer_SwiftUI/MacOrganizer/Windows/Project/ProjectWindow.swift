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
    @State private var selectedContent: ProjectContent?

    private let store: ProjectStoreReader = ProjectStore.shared

    @Environment(\.openURL) private var openURL
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Group {
            if let project {
                ContentView(project: project, selected: self.$selectedContent)
            } else {
                ProjectUnavailableView()
            }
        }
        .background(.listBackground)
        .onChange(of: self.selectedContent) {
            if let selectedContent {
                self.openURL(selectedContent.url)
                self.selectedContent = nil
            }
        }
    }
}

private extension ProjectWindow {
    var project: Project? {
        guard let projectID else { return nil }
        return self.store.project(for: projectID, in: self.modelContext)
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
