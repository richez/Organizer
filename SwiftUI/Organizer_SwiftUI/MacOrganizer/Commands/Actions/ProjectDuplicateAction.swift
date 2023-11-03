//
//  ProjectDuplicateAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectDuplicateAction: View {
    var project: Project?
    var context: ModelContext

    private let store: ProjectStoreWritter = ProjectStore()

    var body: some View {
        Button("Duplicate") {
            if let project {
                self.store.duplicate(project, in: self.context)
            }
        }
        .keyboardShortcut("d", modifiers: .command)
    }
}
