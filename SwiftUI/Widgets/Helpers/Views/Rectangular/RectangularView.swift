//
//  RectangularView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI
import WidgetKit

struct RectangularView: View {
    var title: String
    var subtitle: String

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Spacer()

                Text(self.subtitle)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}
