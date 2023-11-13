//
//  FormSection.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 14/10/2023.
//

import SwiftUI

struct FormSection<Content: View>: View {
    var title: LocalizedStringKey
    var content: () -> Content

    init(_ title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        Section(self.title) {
            self.content()
        }
        .foregroundStyle(.white)
        .font(.system(size: 13))
    }
}

#Preview {
    Form {
        FormSection("Name") {
            Text("Jon Doe")
                .foregroundStyle(.black)
        }
    }
    .background(Color.listBackground)
    .scrollContentBackground(.hidden)
}
