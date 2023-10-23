//
//  ProjectDeleteAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectDeleteAction: View {
    var selectedProject: Binding<Project?>?
    var context: ModelContext

    private let store: ProjectStoreWritter = ProjectStore.shared

    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        Button("Delete") {
            if let project = self.selectedProject?.wrappedValue {
                self.store.delete(project, in: self.context)
                self.selectedProject?.wrappedValue = nil
                self.dismissWindow(value: project.persistentModelID)
            }
        }
        .keyboardShortcut(.delete, modifiers: .command)
    }
}
