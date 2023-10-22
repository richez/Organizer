//
//  FloatingButton.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingButton: View {
    let title: String
    let systemName: String
    let action: () -> Void

    init(_ title: String, systemName: String, action: @escaping () -> Void) {
        self.title = title
        self.systemName = systemName
        self.action = action
    }

    var body: some View {
        HStack {
            Spacer()
            Button(self.title, systemImage: self.systemName) {
                self.action()
            }
            .modifier(FloatingButtonViewModifier())
        }
        .padding()
    }
}
