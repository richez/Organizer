//
//  ContentHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentHeaderView: View {
    var project: Project

    private let viewModel = ViewModel()

    var body: some View {
        HStack {
            Menu {
                // TODO: Test + check if theme is added after creation
                ContentListSortingMenu(suiteName: self.suiteName)
                ContentListPreviewStyleMenu(suiteName: self.suiteName)
                ContentListThemeMenu(themes: self.themes, suiteName: self.suiteName)
                ContentListTypeMenu(suiteName: self.suiteName)
            } label: {
                Text(self.project.title)
                    .font(.system(size: 15, weight: .heavy))
            }
            .menuStyle(.borderlessButton)
            .fixedSize(horizontal: true, vertical: false)
            .tint(.cellTitle)

            Spacer()

            Button {

            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .padding()
    }
}

private extension ContentHeaderView {
    var suiteName: String {
        self.project.suiteName
    }

    var themes: [String] {
        self.viewModel.themes(in: self.project)
    }
}

#Preview {
    ContentHeaderView(project: PreviewDataGenerator.project)
        .background(.listBackground)
}
