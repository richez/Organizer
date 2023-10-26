//
//  LastProjectEntryView.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

struct LastProjectEntryView: View {
    var entry: LastProjectEntry
    
    var body: some View {
        Text("Hello World!")
            .containerBackground(for: .widget) {
                Color.listBackground
            }
    }
}
