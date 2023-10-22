//
//  StatisticsContentView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

struct StatisticsContentView: View {
    var title: String
    var number: Int
    var systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack {
                Text("\(self.number)")
                    .font(.headline)
                    .foregroundStyle(.statisticsText)
                Spacer()
                Image(systemName: self.systemImage)
                    .font(.title3)
                    .foregroundStyle(.statisticsSubtext)
            }

            Text(self.title)
                .font(.subheadline)
                .foregroundStyle(.statisticsSubtext)
        }
        .padding()
        .background(.statisticsRowBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        Color.listBackground
        StatisticsContentView(
            title: "Contents",
            number: 66,
            systemImage: "number"
        )
        .padding()
    }
    .frame(width: 200, height: 200)
}
