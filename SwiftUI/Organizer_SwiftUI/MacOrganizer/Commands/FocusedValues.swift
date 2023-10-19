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

extension FocusedValues {
    var showProjectForm: Binding<Bool>? {
        get { self[ShowProjectFormKey.self] }
        set { self[ShowProjectFormKey.self] = newValue }
    }
}
