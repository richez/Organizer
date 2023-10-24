//
//  FocusedValues.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI
// TODO: move to macOS only
// MARK: - Project

extension FocusedValues {
    // MARK: Selected

    private struct SelectedProjectKey: FocusedValueKey {
        typealias Value = Binding<Project?>
    }

    var selectedProject: Binding<Project?>? {
        get { self[SelectedProjectKey.self] }
        set { self[SelectedProjectKey.self] = newValue }
    }

    // MARK: Form

    private struct ShowingProjectFormKey: FocusedValueKey {
        typealias Value = Binding<Bool>
    }

    var isShowingProjectForm: Binding<Bool>? {
        get { self[ShowingProjectFormKey.self] }
        set { self[ShowingProjectFormKey.self] = newValue }
    }

    // MARK: Editing

    #if os(macOS)
    private struct EditingProjectFormKey: FocusedValueKey {
        typealias Value = Binding<Project?>
    }

    var isEditingProject: Binding<Project?>? {
        get { self[EditingProjectFormKey.self] }
        set { self[EditingProjectFormKey.self] = newValue }
    }
    #endif
}

// MARK: - Content

extension FocusedValues {
    // MARK: Selected

    private struct SelectedContentKey: FocusedValueKey {
        typealias Value = Binding<ProjectContent?>
    }

    var selectedContent: Binding<ProjectContent?>? {
        get { self[SelectedContentKey.self] }
        set { self[SelectedContentKey.self] = newValue }
    }

    // MARK: Form

    #if os(macOS)
    private struct ShowingContentFormKey: FocusedValueKey {
        typealias Value = Binding<Bool>
    }

    var isShowingContentForm: Binding<Bool>? {
        get { self[ShowingContentFormKey.self] }
        set { self[ShowingContentFormKey.self] = newValue }
    }
    #endif
}

// MARK: - Statistics

extension FocusedValues {
    #if os(macOS)
    private struct ShowingStatisticsKey: FocusedValueKey {
        typealias Value = Binding<Bool>
    }

    var isShowingStatistics: Binding<Bool>? {
        get { self[ShowingStatisticsKey.self] }
        set { self[ShowingStatisticsKey.self] = newValue }
    }
    #endif
}
