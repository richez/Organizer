//
//  ContentContainerView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct ContentContainerView<Content: View>: View {
    var systemImage: String
    var content: () -> Content

    init(systemImage: String, @ViewBuilder content: @escaping () -> Content) {
        self.systemImage = systemImage
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            self.content()

            Spacer()

            Image(systemName: self.systemImage)
                .foregroundStyle(.launchscreenBackground)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
