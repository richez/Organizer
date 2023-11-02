//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct ProjectRow: View {
    var project: Project
    var isSelected: Bool

    private let viewModel = ViewModel()

    @AppStorage(.projectListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.projectListShowStatistics)
    private var showStatistics: Bool = true

    var body: some View {
        HStack {
            ProjectRowSelectedIndicator()
                .opacity(self.isSelected ? 1 : 0)

            VStack(alignment: .leading, spacing: 8) {
                Text(self.project.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(2)

                VStack(alignment: .leading, spacing: 5) {
                    if self.showTheme {
                        Text(self.themes)
                            .lineLimit(1)
                    }

                    if self.showStatistics {
                        Text(self.statistics)
                            .lineLimit(2)
                    }
                }
                .font(.system(size: 12))
                .foregroundStyle(.cellSubtitle)

                Text(self.updatedDate)
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.cellDate)
            }
        }
    }
}

private extension ProjectRow {
    var themes: String {
        self.viewModel.themes(from: self.project.theme)
    }

    var statistics: String {
        self.viewModel.statistics(from: self.project.contents)
    }

    var updatedDate: String {
        self.viewModel.updatedDate(from: self.project.updatedDate)
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
