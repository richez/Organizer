//
//  OrganizerCommands.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

// TODO: fix forms in light mode

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

                Button("Duplicate") {

                }
                .keyboardShortcut("d", modifiers: .command)

                Divider()

                Button("New Content") {

                }
                .keyboardShortcut("c", modifiers: [.command, .shift])
                Button("Edit How to choose...") {

                }
                .keyboardShortcut("e", modifiers: [.command, .shift])
                Button("Delete How to choose...") {
                    // add prefix(10) to name
                }
                .keyboardShortcut(.delete, modifiers: [.command, .shift])
            }
            .disabled(self.selectedProject == nil)
        }
    }
}
