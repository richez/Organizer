//
//  ProjectForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectForm: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var theme: String = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                Section("Name") {
                    TextField("My project", text: self.$title, axis: .vertical)
                        .lineLimit(2)
                        .foregroundStyle(.black)
                }
                .foregroundStyle(.white)

                Section("Themes") {
                    TextField("Sport, Construction, Work", text: self.$theme)
                        .foregroundStyle(.black)
                }
                .foregroundStyle(.white)
            }
            .font(.system(size: 15))
            .padding(.top)
            .background(Color.listBackground)

            FloatingButton(systemName: "checkmark") {
                self.dismiss()
            }
        }
    }
}

#Preview {
    ProjectForm()
}
