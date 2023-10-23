//
//  StatisticsContentView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

enum StatisticsContentType {
    case constant(String, number: Int)
    case dynamic([String: Int])
}

struct StatisticsContentView: View {
    var type: StatisticsContentType
    var systemImage: String

    @State private var selectedElement: String = ""

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

            self.titleView
        }
        .padding()
        .background(.statisticsRowBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            switch self.type {
            case .constant:
                break
            case .dynamic(let elements):
                self.selectedElement = elements.max { $0.value < $1.value }?.key ?? ""
            }
        }
    }
}

private extension StatisticsContentView {
    var number: Int {
        switch self.type {
        case .constant(_, let number):
            return number
        case .dynamic(let elements):
            return elements[self.selectedElement] ?? 0
        }
    }

    @ViewBuilder
    var titleView: some View {
        switch self.type {

        case .constant(let title, _):
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.statisticsSubtext)

        case .dynamic(let elements):
            Menu {
                Picker("Select element", selection: self.$selectedElement) {
                    ForEach(Array(elements.keys).sorted(), id: \.self) { key in
                        Text(key)
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
            } label: {
                Text(self.selectedElement.capitalized)
                    .font(.subheadline)
                    .foregroundStyle(.statisticsSubtext)
            }
            .menuStyle(.borderlessButton)
            .fixedSize(horizontal: true, vertical: false)
            .tint(.statisticsSubtext)
        }
    }
}

#Preview("Constant") {
    ZStack {
        Color.listBackground
        StatisticsContentView(
            type: .constant("Contents", number: 66),
            systemImage: "number"
        )
        .padding()
    }
    .frame(width: 200, height: 200)
}

#Preview("Dynamic") {
    ZStack {
        Color.listBackground
        StatisticsContentView(
            type: .dynamic(["video": 5, "article": 20]),
            systemImage: "number"
        )
        .padding()
    }
    .frame(width: 200, height: 200)
}
