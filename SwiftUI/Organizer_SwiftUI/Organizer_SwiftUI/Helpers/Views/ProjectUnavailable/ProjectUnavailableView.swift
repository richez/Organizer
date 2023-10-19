//
//  ProjectUnavailableView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ProjectUnavailableView: View {
    var body: some View {
        ContentUnavailableView {
            VStack(spacing: 20) {
                Image(systemName: "filemenu.and.selection")
                Text("Select a project")
            }
            .font(.largeTitle)
            .foregroundStyle(.white)
            .background(.listBackground)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ProjectUnavailableView()
    }
}
