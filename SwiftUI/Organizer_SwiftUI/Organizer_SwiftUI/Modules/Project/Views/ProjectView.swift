//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @Binding var selected: Project?
    private let viewModel = ViewModel()

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            ProjectListContainerView(selected: self.$selected)

            FloatingButtonSheet(systemName: "square.and.pencil") {
                ProjectForm()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.viewModel.navbarTitle)
                        .font(.headline)
                    Text(self.navbarSubtitle)
                        .font(.subheadline)
                }
                .foregroundStyle(.accent)
            }
        }
    }
}

private extension ProjectView {
    var navbarSubtitle: String {
        self.viewModel.navbarSubtitle(for: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView(selected: .constant(nil))
        }
    }
}
