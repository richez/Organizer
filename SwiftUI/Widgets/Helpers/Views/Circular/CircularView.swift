//
//  CircularView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct CircularView: View {
    var systemImage: String

    var body: some View {
        Image(systemName: self.systemImage)
            .font(.system(size: 17, weight: .bold))
            .padding(10)
            .background(.floatingButton)
            .clipShape(.circle)
    }
}
