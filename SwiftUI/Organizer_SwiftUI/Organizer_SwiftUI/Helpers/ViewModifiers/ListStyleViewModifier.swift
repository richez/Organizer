//
//  ListStyleViewModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ListStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
            .toolbarBackground(.listBackground)
            .toolbarBackground(.visible)
    }
}

extension View {
    func listStyle() -> some View {
        self.modifier(ListStyleViewModifier())
    }
}
