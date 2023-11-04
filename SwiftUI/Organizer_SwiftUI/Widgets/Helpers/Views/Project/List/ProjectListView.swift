//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI

struct ProjectListView: View {
    var projects: [Project]
    var placeholders: Int

    var body: some View {
        ContentContainerView(systemImage: "ellipsis") {
            ForEach(self.projects) { project in
                ProjectRow(project: project)
            }
            ForEach(0..<self.placeholders, id: \.self) { _ in
                VStack(alignment: .leading) {
                    ForEach([80, 120], id: \.self) { width in
                        Capsule()
                            .fill(.cellSeparatorTint)
                            .frame(width: width, height: 10)
                    }
                }
                .padding(.bottom, 10)
                .redacted(reason: .placeholder)
            }
        }
    }
}
