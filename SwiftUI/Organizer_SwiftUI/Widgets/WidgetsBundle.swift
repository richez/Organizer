//
//  WidgetsBundle.swift
//  Widgets
//
//  Created by Thibaut Richez on 26/10/2023.
//

import WidgetKit
import SwiftUI

@main
struct WidgetsBundle: WidgetBundle {
    var body: some Widget {
        AddProjectWidget()
        LastProjectWidget()
        ProjectsWidget()
    }
}
