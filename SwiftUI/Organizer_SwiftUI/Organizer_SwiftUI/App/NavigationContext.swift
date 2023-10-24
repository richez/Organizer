//
//  NavigationContext.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

@Observable
final class NavigationContext {
    var columnVisibility: NavigationSplitViewVisibility = .all
    var selectedProject: Project?
    var selectedContentURL: URL?

    #if os(macOS)
    var isShowingStatistics: Bool = false
    #endif
}
