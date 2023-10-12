//
//  FloatingButtonSheet.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingButtonSheet<Content: View>: View {
    @State var isSelected: Bool = false

    let systemName: String
    let content: () -> Content

    init(systemName: String, @ViewBuilder content: @escaping () -> Content) {
        self.systemName = systemName
        self.content = content
    }

    var body: some View {
        FloatingButton(systemName: self.systemName) {
            self.isSelected.toggle()
        }
        .sheet(isPresented: self.$isSelected) {
            self.content()
        }
    }
}
