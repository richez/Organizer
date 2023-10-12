//
//  FloatingButtonSheet.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct FloatingButtonSheet<Content: View>: View {
    @State var isShowingSheet: Bool = false

    let systemName: String
    let content: () -> Content

    init(systemName: String, @ViewBuilder content: @escaping () -> Content) {
        self.systemName = systemName
        self.content = content
    }

    var body: some View {
        FloatingButton(systemName: self.systemName) {
            self.isShowingSheet.toggle()
        }
        .sheet(isPresented: self.$isShowingSheet) {
            self.content()
        }
    }
}
