//
//  ProjectFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct ProjectFormAction: View {
    @Binding var showProjectForm: Bool?

    var body: some View {
        Button("New Project") {
            self.showProjectForm?.toggle()
        }
        .keyboardShortcut("n", modifiers: [.shift, .command])
        .disabled(self.showProjectForm == true)
    }
}
