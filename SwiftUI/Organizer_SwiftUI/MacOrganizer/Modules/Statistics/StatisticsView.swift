//
//  StatisticsView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

struct StatisticsView: View {
    var project: Project

    private let viewModel = ViewModel()

    var body: some View {
        Grid {
            Text("Statistics")
                .foregroundStyle(.statisticsSubtext)
                .padding(.bottom)

            GridRow {
                StatisticsContentView(
                    title: "Contents",
                    number: self.project.contents.count,
                    systemImage: "doc"
                )
                StatisticsContentView(
                    title: "Themes",
                    number: self.project.contents.count,
                    systemImage: "number"
                )
            }

            GridRow {
                let maxContentType = self.viewModel.maxContentType(in: self.project)
                StatisticsContentView(
                    title: maxContentType?.name.capitalized ?? "placeholder",
                    number: maxContentType?.count ?? 0,
                    systemImage: "doc"
                )
                .redacted(reason: maxContentType == nil ? .placeholder : [])

                let maxContentTheme = self.viewModel.maxContentTheme(in: self.project)
                StatisticsContentView(
                    title: maxContentTheme?.name.capitalized ?? "placeholder",
                    number: maxContentTheme?.count ?? 0,
                    systemImage: "number"
                )
                .redacted(reason: maxContentTheme == nil ? .placeholder : [])
            }

            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
            }
            
            GridRow {
                StatisticsDateContainerView(
                    created: self.createdDate,
                    updated: self.updatedDate
                )
                .gridCellColumns(2)
            }
        }
        .padding()
        .background(.listBackground)
    }
}

extension StatisticsView {
    var createdDate: String {
        self.viewModel.formattedDate(from: self.project.createdDate)
    }

    var updatedDate: String {
        self.viewModel.formattedDate(from: self.project.updatedDate)
    }
}

#Preview {
    ModelContainerPreview {
        StatisticsView(project: PreviewDataGenerator.project)
    }
    .frame(width: 300, height: 420)
}
