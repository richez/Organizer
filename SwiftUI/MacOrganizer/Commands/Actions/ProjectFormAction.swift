//
//  ProjectFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct ProjectFormAction: View {
    @FocusedBinding(\.isShowingProjectForm) private var isShowingForm

    var body: some View {
        Button("New Project") {
            self.isShowingForm?.toggle()
        }
        .keyboardShortcut("n", modifiers: [.shift, .command])
        .disabled(self.isShowingForm == true)
    }
}
