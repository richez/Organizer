//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        VStack {
            ProjectHeaderView()
            ProjectListContainerView()
        }
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
