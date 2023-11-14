//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct ProjectRow: View {
    var isSelected: Bool

    @State private var viewModel: ViewModel

    @AppStorage(.projectListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.projectListShowStatistics)
    private var showStatistics: Bool = true

    init(project: Project, isSelected: Bool) {
        self._viewModel = State(initialValue: ViewModel(project: project))
        self.isSelected = isSelected
    }

    var body: some View {
        HStack {
            ProjectRowSelectedIndicator()
                .opacity(self.isSelected ? 1 : 0)

            VStack(alignment: .leading, spacing: 8) {
                Text(self.viewModel.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(2)

                VStack(alignment: .leading, spacing: 5) {
                    if self.showTheme {
                        Text(self.viewModel.themes)
                            .lineLimit(1)
                    }

                    if self.showStatistics {
                        Text(self.viewModel.statistics)
                            .lineLimit(2)
                    }
                }
                .font(.system(size: 12))
                .foregroundStyle(.cellSubtitle)

                Text(self.viewModel.updatedDate)
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.cellDate)
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        List {
            ProjectRow(project: PreviewDataGenerator.project, isSelected: true)
                .listRowBackground(Color.listBackground)
        }
        .listStyle()
    }
}
