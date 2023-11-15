//
//  ContentRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct ContentRow: View {
    @State private var viewModel: ViewModel

    init(content: ProjectContent) {
        self._viewModel = State(initialValue: ViewModel(content: content))
    }

    var body: some View {
        HStack(spacing: 15) {

            Image(systemName: self.viewModel.systemImage)
                .foregroundStyle(.contentImageTint)

            VStack(alignment: .leading, spacing: 1) {
                Text(self.viewModel.title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(1)
                    .padding(.top)

                Text(self.viewModel.themes)
                    .font(.system(size: 7))
                    .foregroundStyle(.cellSubtitle)
                    .lineLimit(1)
            }
        }
        .deeplink(.content(id: self.viewModel.contentID, projectID: self.viewModel.projectID))
    }
}
