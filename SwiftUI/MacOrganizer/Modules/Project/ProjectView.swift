//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @Environment(NavigationContext.self) private var navigationContext

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        VStack {
            ProjectHeaderView()
            ProjectListContainerView()
        }
        .focusedSceneValue(\.selectedProject, $navigationContext.selectedProject)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView()
                .background(.listBackground)
        }
    }
}
