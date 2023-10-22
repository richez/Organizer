//
//  FloatingButtonSheet.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingButtonSheet<Content: View>: View {
    @State var isShowingSheet: Bool = false

    let title: String
    let systemName: String
    let content: () -> Content

    init(_ title: String, systemName: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.systemName = systemName
        self.content = content
    }

    var body: some View {
        FloatingButton(self.title, systemName: self.systemName) {
            self.isShowingSheet.toggle()
        }
        .sheet(isPresented: self.$isShowingSheet) {
            self.content()
        }
    }
}
