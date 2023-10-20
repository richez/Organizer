//
//  OrganizerCommands.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct OrganizerCommands: Commands {
    @FocusedBinding(\.showProjectForm) private var showProjectForm

    var body: some Commands {
        SidebarCommands()

        CommandGroup(after: .newItem) {
            Button("New Project") {
                self.showProjectForm?.toggle()
            }
            .keyboardShortcut("n", modifiers: [.shift, .command])
            .disabled(self.showProjectForm == true)
        }

        CommandMenu("Project") {
            Text("Self-Build")

            Button("Open In New Window") {

            }

            Divider()

            Button("Edit") {

            }
            .keyboardShortcut("e", modifiers: .command)
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
    }
}
