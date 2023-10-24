//
//  ContentHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentHeaderView: View {
    var project: Project

    private let store: ContentStoreDescriptor & ContentStoreReader = ContentStore.shared

    @Environment(NavigationContext.self) private var navigationContext

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(project: Project) {
        self.project = project

        let defaults = UserDefaults(suiteName: project.identifier.uuidString)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
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

            if self.hasFilter {
                Text(self.filters)
                    .foregroundStyle(.cellTitle.opacity(0.8))

                Button("Reset") {
                    self.selectedTheme = nil
                    self.selectedType = nil
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.blue.opacity(0.8))
            }

            Spacer()

            HStack(spacing: 20) {
                Button("Statistics", systemImage: "info.circle") {
                    self.navigationContext.isShowingStatistics.toggle()
                }
                .focusedSceneValue(\.showStatistics, $navigationContext.isShowingStatistics)
                .popover(isPresented: $navigationContext.isShowingStatistics) {
                    StatisticsView(project: self.project)
                }

                Button("Add Content", systemImage: "plus") {
                    self.navigationContext.isShowingContentForm.toggle()
                }
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .focusedSceneValue(\.showContentForm, $navigationContext.isShowingContentForm)
        .sheet(isPresented: $navigationContext.isShowingContentForm) {
            ContentForm(project: self.project)
        }
        .padding()
    }
}

private extension ContentHeaderView {
    var suiteName: String {
        self.project.identifier.uuidString
    }

    var themes: [String] {
        self.store.themes(in: self.project)
    }

    var hasFilter: Bool {
        self.selectedTheme != nil || self.selectedType != nil
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
