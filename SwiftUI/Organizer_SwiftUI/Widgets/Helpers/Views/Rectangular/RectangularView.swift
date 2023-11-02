//
//  RectangularView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct RectangularView: View {
    var title: String
    var subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(1)

                Spacer()

                Text(self.subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.cellSubtitle)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding([.top, .bottom])
    }
}
