//
//  CommandsFocusedValues.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

private struct EditingProjectFormKey: FocusedValueKey {
    typealias Value = Binding<Project?>
}

private struct ShowingContentFormKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

private struct ShowingStatisticsKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

extension FocusedValues {
    var isEditingProject: Binding<Project?>? {
        get { self[EditingProjectFormKey.self] }
        set { self[EditingProjectFormKey.self] = newValue }
    }

    var isShowingContentForm: Binding<Bool>? {
        get { self[ShowingContentFormKey.self] }
        set { self[ShowingContentFormKey.self] = newValue }
    }

    var isShowingStatistics: Binding<Bool>? {
        get { self[ShowingStatisticsKey.self] }
        set { self[ShowingStatisticsKey.self] = newValue }
    }
}
