//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    @Query private var projects: [Project]

    var body: some View {
        List {
            ForEach(self.projects) { project in
                Text(project.title)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.listBackground)
            }
        }
        .background(.listBackground)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ProjectListView()
        .previewModelContainer()
}
