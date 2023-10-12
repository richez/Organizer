//
//  FloatingButton.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingButton: View {
    let systemName: String
    let action: () -> Void

    init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }

    var body: some View {
        HStack {
            Spacer()
            Button {
                self.action()
            } label: {
                Image(systemName: self.systemName)
                    .modifier(FloatingButtonViewModifier())
            }
        }
        .padding()
    }
}
