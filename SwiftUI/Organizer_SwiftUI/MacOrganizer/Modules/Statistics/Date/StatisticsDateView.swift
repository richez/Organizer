//
//  StatisticsDateView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

struct StatisticsDateView: View {
    var title: String
    var date: String

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.date)
                    .font(.headline)
                    .foregroundStyle(.statisticsText)
                Text(self.title)
                    .font(.subheadline)
                    .foregroundStyle(.statisticsSubtext)
            }

            Spacer()

            Image(systemName: "calendar")
                .foregroundStyle(.statisticsSubtext)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground
        StatisticsDateView(title: "Created", date: "22 Oct 2023 at 20:06")
            .padding()
    }
    .frame(width: 300, height: 200)
}
