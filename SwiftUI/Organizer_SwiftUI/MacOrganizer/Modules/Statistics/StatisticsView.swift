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
                .font(.subheadline)
                .foregroundStyle(.statisticsSubtext)
                .padding(.bottom)

            GridRow {
                StatisticsContentView(
                    type: .constant("Contents", number: self.numberOfContents),
                    systemImage: "doc"
                )
                StatisticsContentView(
                    type: .constant("Themes", number: self.numberOfThemes),
                    systemImage: "number"
                )
            }

            GridRow {
                StatisticsContentView(
                    type: .dynamic(self.contentTypeCounts),
                    systemImage: "doc"
                )
                .redacted(reason: self.contentTypeCounts.isEmpty ? .placeholder : [])

                StatisticsContentView(
                    type: .dynamic(self.contentThemeCounts),
                    systemImage: "number"
                )
                .redacted(reason: self.contentThemeCounts.isEmpty ? .placeholder : [])
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
        .frame(width: 280)
        .preferredColorScheme(.dark)
    }
}

extension StatisticsView {
    var numberOfContents: Int {
        self.viewModel.numberOfContents(in: self.project)
    }

    var numberOfThemes: Int {
        self.viewModel.numberOfThemes(in: self.project)
    }

    var contentTypeCounts: [String: Int] {
        self.viewModel.contentTypeCounts(in: self.project)
    }

    var contentThemeCounts: [String: Int] {
        self.viewModel.contentThemeCounts(in: self.project)
    }

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
    .frame(width: 280, height: 410)
}
