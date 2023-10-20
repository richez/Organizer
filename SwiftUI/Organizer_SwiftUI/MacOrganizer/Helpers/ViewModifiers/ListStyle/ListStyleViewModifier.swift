//
//  ListStyleViewModifier.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ListStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
            .toolbarBackground(.listBackground)
            .toolbarColorScheme(.dark)
    }
}

extension View {
    func listStyle() -> some View {
        self.modifier(ListStyleViewModifier())
    }
}
