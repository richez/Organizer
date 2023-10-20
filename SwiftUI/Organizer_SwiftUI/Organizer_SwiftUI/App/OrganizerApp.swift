//
//  OrganizerApp.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

@main
struct OrganizerApp: App {
    var container: ModelContainer

    init() {
        do {
            self.container = try ModelContainer(for: Project.self, ProjectContent.self)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .commands {
            OrganizerCommands()
        }
        #endif
        .modelContainer(self.container)

        #if os(macOS)
        WindowGroup(for: PersistentIdentifier.self) { $id in
            ProjectWindow(projectID: $id)
        }
        .modelContainer(self.container)
        .windowStyle(.hiddenTitleBar)
        .commandsRemoved()
        #endif
    }
}
