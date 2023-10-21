//
//  ContentFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 21/10/2023.
//

import SwiftUI

struct ContentFormAction: View {
    @FocusedBinding(\.showContentForm) private var showContentForm

    var body: some View {
        Button("New Content") {
            self.showContentForm?.toggle()
        }
        .keyboardShortcut("c", modifiers: [.command, .shift])
        .disabled(self.showContentForm == true)
    }
}
