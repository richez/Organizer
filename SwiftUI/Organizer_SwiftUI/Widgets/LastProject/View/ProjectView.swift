//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 27/10/2023.
//

import SwiftUI

struct ProjectView: View {
    var project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(project.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.cellTitle)
                .lineLimit(2)

            Group {
                Text("#DIY")
                    .lineLimit(1)
                Text("4 contents (1 articles, 2 videos)")
            }
            .font(.system(size: 12))
            .foregroundStyle(.cellSubtitle)
        }
    }
}
