//
//  StatisticsDateContainerView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

struct StatisticsDateContainerView: View {
    var created: String
    var updated: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            StatisticsDateView(title: "Modified", date: self.updated)
                .padding([.top, .leading, .trailing])

            Divider()
                .overlay(.listBackground)

            StatisticsDateView(title: "Created", date: self.created)
                .padding([.bottom, .leading, .trailing])
        }
        .background(.statisticsRowBackground)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        Color.listBackground
        StatisticsDateContainerView(
            created: "22 Oct 2023 at 20:06",
            updated: "1 Oct 2023 at 12:41"
        )
        .padding()
    }
    .frame(width: 300, height: 200)
}
