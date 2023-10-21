//
//  OrganizerCommands.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct OrganizerCommands: Commands {
    @FocusedValue(\.selectedProject) private var selectedProject
    @Environment(\.modelContext) private var modelContext

    var body: some Commands {
        SidebarCommands()

        CommandGroup(after: .newItem) {
            ProjectFormAction()
        }

        CommandMenu("Project") {
            Group {
                if let project = self.selectedProject?.wrappedValue {
                    Text(project.title)
                }

                OpenProjectWindowAction(project: self.selectedProject?.wrappedValue)

                Divider()

                ProjectEditorFormAction(project: self.selectedProject?.wrappedValue)

                ProjectDeleteAction(selectedProject: self.selectedProject, context: self.modelContext)

                ProjectDuplicateAction(project: self.selectedProject?.wrappedValue, context: self.modelContext)

                Divider()

                ContentFormAction()
            }
            .disabled(self.selectedProject == nil)
        }
    }
}
