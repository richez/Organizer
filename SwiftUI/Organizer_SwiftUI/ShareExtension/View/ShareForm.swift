//
//  ShareForm.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI

struct ShareForm: View {
    let content: ShareContent
    let finishAction: () -> Void

    @Query(sort: \Project.updatedDate, order: .reverse)
    private var projects: [Project]

    @State private var selectedProject: Project?

    var body: some View {
        Form {
            Picker("Project", selection: self.$selectedProject) {
                ForEach(self.projects) { project in
                    Text(project.title)
                }
            }
        }
    }
}
