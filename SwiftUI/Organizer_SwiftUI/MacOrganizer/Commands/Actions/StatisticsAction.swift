//
//  StatisticsAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

struct StatisticsAction: View {
    @FocusedBinding(\.showStatistics) private var showStatistics

    var body: some View {
        Button("Toggle Statistics Panel") {
            self.showStatistics?.toggle()
        }
        .keyboardShortcut("i", modifiers: [.shift, .command])
    }
}
