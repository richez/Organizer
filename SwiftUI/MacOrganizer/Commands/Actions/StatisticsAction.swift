//
//  StatisticsAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

struct StatisticsAction: View {
    @FocusedBinding(\.isShowingStatistics) private var isShowingStatistics

    var body: some View {
        Button("Toggle Statistics Panel") {
            self.isShowingStatistics?.toggle()
        }
        .keyboardShortcut("i", modifiers: [.shift, .command])
    }
}
