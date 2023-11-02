//
//  EmptyProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct EmptyProjectView: View {
    var body: some View {
        ContentContainerView(systemImage: "ellipsis") {
            Group {
                Image(.launchscreenLogo)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.cellSubtitle)
                    .frame(width: 60, height: 60)

                Text("Tap and create your first project")
                    .font(.system(size: 10, weight: .light))
                    .foregroundStyle(.cellSubtitle)
                    .multilineTextAlignment(.center)
            }
            .padding([.leading, .trailing])
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
