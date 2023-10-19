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
    }
}
