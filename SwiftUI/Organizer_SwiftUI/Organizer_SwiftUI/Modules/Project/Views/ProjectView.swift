//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectView: View {
    private let viewModel = ViewModel()

    @Environment(NavigationContext.self) private var navigationContext

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        ZStack(alignment: .bottom) {
            ProjectListContainerView()

            FloatingButton("Add project", systemName: "square.and.pencil") {
                self.navigationContext.isShowingProjectForm.toggle()
            }
            .sheet(isPresented: $navigationContext.isShowingProjectForm) {
                ProjectForm()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Projects")
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
        self.viewModel.navbarSubtitle(with: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView()
        }
    }
}
