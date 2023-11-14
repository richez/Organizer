//
//  ContextMenuButton.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import SwiftUI

struct ContextMenuButton: View {
    let type: ContextMenuType
    let action: () -> Void

    init(_ type: ContextMenuType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }

    var body: some View {
        Button(self.type.label, systemImage: self.type.systemName) {
            self.action()
        }
    }
}
