//
//  ContentFormAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 21/10/2023.
//

import SwiftUI

struct ContentFormAction: View {
    @FocusedBinding(\.isShowingContentForm) private var isShowingContentForm

    var body: some View {
        Button("New Content") {
            self.isShowingContentForm?.toggle()
        }
        .keyboardShortcut("c", modifiers: [.command, .shift])
        .disabled(self.isShowingContentForm == true)
    }
}
