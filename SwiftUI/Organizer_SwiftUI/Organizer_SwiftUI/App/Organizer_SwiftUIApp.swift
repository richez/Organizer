//
//  Organizer_SwiftUIApp.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

@main
struct Organizer: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(
            for: [Project.self, ProjectContent.self], isAutosaveEnabled: true
        )
    }
}
