//
//  ContentRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ContentRow: View {
    var content: ProjectContent

    private let viewModel = ViewModel()

    @AppStorage(.contentListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.contentListShowType)
    private var showType: Bool = true

    init(content: ProjectContent, suiteName: String) {
        self.content = content

        let defaults = UserDefaults(suiteName: suiteName)
        self._showTheme.update(with: defaults, key: .contentListShowTheme)
        self._showType.update(with: defaults, key: .contentListShowType)
    }

    var body: some View {
        HStack(spacing: 15) {

            if self.showType {
                Image(systemName: self.content.type.systemImage)
                    .foregroundStyle(.contentImageTint)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(self.content.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.cellTitle)
                    .lineLimit(2)
                    .padding(.top)

                if self.showTheme {
                    Text(self.themes)
                        .font(.system(size: 12))
                        .foregroundStyle(.cellSubtitle)
                        .lineLimit(1)
                }
            }
        }
    }
}

private extension ContentRow {
    var themes: String {
        self.viewModel.themes(from: self.content.theme)
    }
}

#Preview {
    ModelContainerPreview {
        List {
            ContentRow(
                content: PreviewDataGenerator.content,
                suiteName: "test"
            )
            .listRowBackground(Color.listBackground)
        }
        .listStyle()
    }
}