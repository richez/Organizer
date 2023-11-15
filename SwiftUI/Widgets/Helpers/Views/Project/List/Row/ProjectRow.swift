//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI

struct ProjectRow: View {
    @State private var viewModel: ViewModel
    @Environment(\.widgetFamily) private var widgetFamily

    init(project: Project) {
        self._viewModel = State(initialValue: ViewModel(project: project))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(self.viewModel.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.cellTitle)
                .lineLimit(1)

            Text(self.viewModel.statistics)
                .font(.system(size: 12))
                .foregroundStyle(.cellSubtitle)
                .lineLimit(1)
        }
        .padding(.bottom, self.padding)
        .deeplink(.project(id: self.viewModel.projectID))
    }
}

private extension ProjectRow {
    var padding: CGFloat {
        switch self.widgetFamily {
        case .systemMedium: 3
        default: 8
        }
    }
}
