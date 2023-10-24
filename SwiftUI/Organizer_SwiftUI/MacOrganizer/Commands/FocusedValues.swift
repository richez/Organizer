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

private struct ShowProjectEditorFormKey: FocusedValueKey {
    typealias Value = Binding<Project?>
}

private struct SelectedProject: FocusedValueKey {
    typealias Value = Binding<Project?>
}

private struct ShowContentFormKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

private struct ShowStatistics: FocusedValueKey {
    typealias Value = Binding<Bool>
}

extension FocusedValues {
    var showProjectForm: Binding<Bool>? {
        get { self[ShowProjectFormKey.self] }
        set { self[ShowProjectFormKey.self] = newValue }
    }

    var showProjectEditorForm: Binding<Project?>? {
        get { self[ShowProjectEditorFormKey.self] }
        set { self[ShowProjectEditorFormKey.self] = newValue }
    }

    var selectedProject: Binding<Project?>? {
        get { self[SelectedProject.self] }
        set { self[SelectedProject.self] = newValue }
    }

    var showContentForm: Binding<Bool>? {
        get { self[ShowContentFormKey.self] }
        set { self[ShowContentFormKey.self] = newValue }
    }

    var showStatistics: Binding<Bool>? {
        get { self[ShowStatistics.self] }
        set { self[ShowStatistics.self] = newValue }
    }
}
