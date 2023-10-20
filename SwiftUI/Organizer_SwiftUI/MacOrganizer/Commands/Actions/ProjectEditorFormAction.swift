//
//  ProjectEditorFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct ProjectEditorFormAction: View {
    var project: Project??
    
    @FocusedBinding(\.showProjectEditorForm) private var showProjectEditorForm

    var body: some View {
        Button("Edit") {
            self.showProjectEditorForm = self.project
        }
        .keyboardShortcut("e", modifiers: .command)
    }
}
