//
//  ProjectRowSelectedIndicator.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 21/10/2023.
//

import SwiftUI

struct ProjectRowSelectedIndicator: View {
    var body: some View {
        Divider()
            .frame(width: 4)
            .overlay(.projectSelectedIndicator)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ProjectRowSelectedIndicator()
}
