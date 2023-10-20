//
//  OpenProjectWindowAction.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import SwiftUI

struct OpenProjectWindowAction: View {
    var project: Project?

    @Environment(\.openWindow) private var openWindow

    var body: some View {
        Button("Open In New Window") {
            if let project {
                self.openWindow(value: project.persistentModelID)
            }
        }
    }
}
