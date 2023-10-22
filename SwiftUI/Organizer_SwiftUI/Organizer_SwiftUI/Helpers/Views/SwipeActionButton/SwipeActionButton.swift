//
//  SwipeActionButton.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct SwipeActionButton: View {
    let type: SwipeActionType
    let action: () -> Void

    init(_ type: SwipeActionType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }

    var body: some View {
        Button(self.type.title, systemImage: self.type.systemName) {
            self.action()
        }
        .labelStyle(.iconOnly)
        .tint(self.type.tint)
    }
}
