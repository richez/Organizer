//
//  AlertViewModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftUI

struct AlertViewModifier: ViewModifier {
    var type: AlertType
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .alert(self.type.title, isPresented: self.$isPresented) {
            } message: {
                Text(self.type.message)
            }
    }
}

extension View {
    func alert(_ type: AlertType, isPresented: Binding<Bool>) -> some View {
        self.modifier(AlertViewModifier(type: type, isPresented: isPresented))
    }
}
