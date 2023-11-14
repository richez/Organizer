//
//  ThemeListView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftData
import SwiftUI

struct ThemeListView: View {
    private let viewModel = ViewModel()

    @Query(ThemeListView.descriptor, animation: .default)
    private var projects: [Project]

    @State private var selectedThemeType: ThemeType = .all

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        List(selection: self.$selectedThemeType) {
            ForEach(self.themeTypes, id: \.self) { themeType in
                Label(themeType.rawValue, systemImage: themeType.systemImage)
                    .foregroundStyle(.cellTitle)
            }
        }
        .padding(.top)
        .background(Color.listBackground.opacity(0.8))
        .onChange(of: self.selectedThemeType) { _, selectedThemeType in
            self.selectedTheme = selectedThemeType.theme
        }
        .onAppear {
            self.selectedThemeType = .init(theme: self.selectedTheme)
        }
    }
}

private extension ThemeListView {
    static var descriptor: FetchDescriptor<Project> {
        var descriptor = FetchDescriptor<Project>(sortBy: [
            SortDescriptor(\.theme, comparator: .localizedStandard, order: .reverse)
        ])
        descriptor.propertiesToFetch = [\.theme]
        return descriptor
    }

    var themeTypes: [ThemeType] {
        self.viewModel.themeTypes(in: self.projects)
    }
}

#Preview {
    ModelContainerPreview {
        ThemeListView()
    }
}
