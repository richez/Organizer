//
//  OrganizerCommands.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

// TODO: fix forms in light mode

struct OrganizerCommands: Commands {
    @FocusedBinding(\.selectedProject) private var selectedProject

    var body: some Commands {
        SidebarCommands()

        CommandGroup(after: .newItem) {
            ProjectFormAction()
        }

        CommandMenu("Project") {
            Group {
                if let title = self.selectedProject??.title {
                    Text(title)
                }

                OpenProjectWindowAction(project: self.selectedProject)

                Divider()

                ProjectEditorFormAction(project: self.selectedProject)

                Button("Delete") {

                }
                .keyboardShortcut(.delete, modifiers: .command)
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
