//
//  ContentHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentHeaderView: View {
    var project: Project

    private let store: ContentStoreDescriptor & ContentStoreReader = ContentStore()

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    @State private var isShowingForm: Bool = false

    init(project: Project) {
        self.project = project

        let defaults = UserDefaults(suiteName: project.suiteName)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        HStack {
            Menu {
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

            Text(self.filters)
                .foregroundStyle(.cellTitle.opacity(0.8))

            Spacer()

            Button {
                self.isShowingForm.toggle()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .sheet(isPresented: self.$isShowingForm) {
            ContentForm(project: self.project)
        }
    }
}

private extension ContentHeaderView {
    var suiteName: String {
        self.project.suiteName
    }

    var themes: [String] {
        self.store.themes(in: self.project)
    }

    var filters: String {
        self.store.filtersDescription(
            for: self.selectedTheme,
            selectedType: self.selectedType
        )
    }
}

#Preview {
    ContentHeaderView(project: PreviewDataGenerator.project)
        .background(.listBackground)
}
