//
//  StatisticsView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 22/10/2023.
//

import SwiftUI

struct StatisticsView: View {
    @State private var viewModel: ViewModel

    init(project: Project) {
        self._viewModel = State(initialValue: ViewModel(project: project))
    }

    var body: some View {
        Grid {
            Text("Statistics")
                .font(.subheadline)
                .foregroundStyle(.statisticsSubtext)
                .padding(.bottom)

            GridRow {
                StatisticsContentView(
                    type: .constant("Contents", number: self.viewModel.numberOfContents),
                    systemImage: "doc"
                )
                StatisticsContentView(
                    type: .constant("Themes", number: self.viewModel.numberOfThemes),
                    systemImage: "number"
                )
            }

            GridRow {
                StatisticsContentView(
                    type: .dynamic(self.viewModel.contentTypeCounts),
                    systemImage: "doc"
                )
                .redacted(reason: self.viewModel.contentTypeCounts.isEmpty ? .placeholder : [])

                StatisticsContentView(
                    type: .dynamic(self.viewModel.contentThemeCounts),
                    systemImage: "number"
                )
                .redacted(reason: self.viewModel.contentThemeCounts.isEmpty ? .placeholder : [])
            }
            
            GridRow {
                StatisticsDateContainerView(
                    created: self.viewModel.createdDate,
                    updated: self.viewModel.updatedDate
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

#Preview {
    ModelContainerPreview {
        StatisticsView(project: PreviewDataGenerator.project)
    }
    .frame(width: 280, height: 410)
}
