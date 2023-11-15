//
//  CircularView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI
import WidgetKit

struct CircularView: View {
    var systemImage: String

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()

            Image(systemName: self.systemImage)
                .font(.system(size: 20, weight: .bold))
                .padding(10)
                .clipShape(.circle)
        }
    }
}
