//
//  FocusedValues.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

private struct ShowProjectFormKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

private struct SelectedProject: FocusedValueKey {
    typealias Value = Binding<Project?>
}

extension FocusedValues {
    var showProjectForm: Binding<Bool>? {
        get { self[ShowProjectFormKey.self] }
        set { self[ShowProjectFormKey.self] = newValue }
    }

    var selectedProject: Binding<Project?>? {
        get { self[SelectedProject.self] }
        set { self[SelectedProject.self] = newValue }
    }
}
