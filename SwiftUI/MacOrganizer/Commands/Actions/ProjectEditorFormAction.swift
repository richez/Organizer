//
//  ProjectEditorFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct ProjectEditorFormAction: View {
    var project: Project?
    
    @FocusedBinding(\.isEditingProject) private var isEditingProject

    var body: some View {
        Button("Edit") {
            self.isEditingProject = self.project
        }
        .keyboardShortcut("e", modifiers: .command)
    }
}
