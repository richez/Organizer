//
//  FloatingActionButtonModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingActionButtonModifier: ViewModifier {
    var color: Color = .black
    var backgroundColor: Color = .floatingButton
    var fontSize: CGFloat = 25
    var fontWeight: Font.Weight = .light

    func body(content: Content) -> some View {
        content
            .foregroundStyle(self.color)
            .font(.system(size: self.fontSize, weight: self.fontWeight))
            .padding(15)
            .background(self.backgroundColor)
            .clipShape(.circle)
    }
}
