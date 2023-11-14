//
//  ContentRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct ContentRow: View {
    var content: ProjectContent

    private let viewModel = ViewModel()

    var body: some View {
        HStack(spacing: 15) {

            Image(systemName: self.content.type.systemImage)
                .foregroundStyle(.contentImageTint)

            VStack(alignment: .leading, spacing: 1) {
                Text(self.content.title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(1)
                    .padding(.top)

                Text(self.themes)
                    .font(.system(size: 7))
                    .foregroundStyle(.cellSubtitle)
                    .lineLimit(1)
            }
        }
        .deeplink(.content(id: self.contentID, projectID: self.projectID))
    }
}

private extension ContentRow {
    var themes: String {
        self.viewModel.themes(from: self.content.theme)
    }

    var contentID: String {
        self.content.identifier.uuidString
    }

    var projectID: String {
        self.content.project?.identifier.uuidString ?? ""
    }
}
