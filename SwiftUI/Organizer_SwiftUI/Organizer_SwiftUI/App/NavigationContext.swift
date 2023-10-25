//
//  NavigationContext.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import SwiftUI

@Observable
final class NavigationContext {
    var columnVisibility: NavigationSplitViewVisibility = .all
    var selectedProject: Project?
    var isShowingProjectForm: Bool = false
    var selectedContent: ProjectContent?
}
