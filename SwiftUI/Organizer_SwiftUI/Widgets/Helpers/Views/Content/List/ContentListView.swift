//
//  ContentListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct ContentListView: View {
    var contents: [ProjectContent]
    var placeholders: Int

    var body: some View {
        ForEach(self.contents) { content in
            ContentRow(content: content)
        }
        ForEach(0..<self.placeholders, id: \.self) { _ in
            self.placeholderRow
        }
    }
}

private extension ContentListView {
    var placeholderRow: some View {
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 5)
                .fill(.cellSeparatorTint)
                .frame(width: 20, height: 20)

            VStack(alignment: .leading) {
                ForEach([80, 50], id: \.self) { width in
                    Capsule()
                        .fill(.cellSeparatorTint)
                        .frame(width: width, height: 10)
                }
            }
        }
        .padding(.top, 10)
        .redacted(reason: .placeholder)
    }
}
