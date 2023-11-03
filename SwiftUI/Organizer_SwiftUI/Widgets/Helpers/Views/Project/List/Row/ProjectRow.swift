//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI

struct ProjectRow: View {
    var project: Project

    private let viewModel = ViewModel()

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        if let url = Deeplink.project(id: self.projectID).url {
            Link(destination: url) { self.row }
        } else {
            self.row
        }
    }
}

private extension ProjectRow {
    var row: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(self.project.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.cellTitle)
                .lineLimit(1)

            Text(self.statistics)
                .font(.system(size: 12))
                .foregroundStyle(.cellSubtitle)
                .lineLimit(1)
        }
        .padding(.bottom, self.padding)
    }

    var padding: CGFloat {
        switch self.widgetFamily {
        case .systemMedium: 3
        default: 8
        }
    }

    var statistics: String {
        self.viewModel.statistics(from: self.project.contents)
    }

    var projectID: String {
        self.project.identifier.uuidString
    }
}
