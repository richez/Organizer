//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 27/10/2023.
//

import SwiftUI

struct ProjectView: View {
    var project: Project

    private let viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(self.project.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.cellTitle)
                .lineLimit(2)

            Group {
                Text(self.themes)
                    .lineLimit(1)
                Text(self.statistics)
                    .lineLimit(2)
            }
            .font(.system(size: 12))
            .foregroundStyle(.cellSubtitle)
        }
    }
}

extension ProjectView {
    var themes: String {
        self.viewModel.themes(from: self.project.theme)
    }

    var statistics: String {
        self.viewModel.statistics(from: self.project.contents)
    }
}
