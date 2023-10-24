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

    // settings (macOS)
    var isShowingProjectForm: Bool = false
    var isEditingProject: Project?

    var isShowingContentForm: Bool = false
    var isEditingContent: ProjectContent?
}
