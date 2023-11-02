//
//  AddProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct AddProjectView: View {
    var body: some View {
        ContentContainerView(systemImage: "plus") {
            Text("New Project")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.cellTitle)

            Spacer()

            VStack(alignment: .leading) {
                ForEach([70, 90, 80, 50], id: \.self) { width in
                    Capsule()
                        .fill(.cellSeparatorTint)
                        .frame(width: width)
                }
            }
            .redacted(reason: .placeholder)
        }
    }
}
