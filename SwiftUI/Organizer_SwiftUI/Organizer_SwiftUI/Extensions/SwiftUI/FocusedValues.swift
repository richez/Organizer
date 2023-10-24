//
//  FocusedValues.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

private struct SelectedProject: FocusedValueKey {
    typealias Value = Binding<Project?>
}

private struct ShowingProjectFormKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

extension FocusedValues {
    var selectedProject: Binding<Project?>? {
        get { self[SelectedProject.self] }
        set { self[SelectedProject.self] = newValue }
    }

    var isShowingProjectForm: Binding<Bool>? {
        get { self[ShowingProjectFormKey.self] }
        set { self[ShowingProjectFormKey.self] = newValue }
    }
}
