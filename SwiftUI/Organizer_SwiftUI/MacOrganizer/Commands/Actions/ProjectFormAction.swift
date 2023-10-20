//
//  ProjectFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct ProjectFormAction: View {
    @FocusedBinding(\.showProjectForm) private var showProjectForm

    var body: some View {
        Button("New Project") {
            self.showProjectForm?.toggle()
        }
        .keyboardShortcut("n", modifiers: [.shift, .command])
        .disabled(self.showProjectForm == true)
    }
}
