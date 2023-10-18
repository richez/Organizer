//
//  ProjectHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectHeaderView: View {
    @State private var isShowingForm: Bool = false

    var body: some View {
        HStack {
            HStack {
                Text("Projects")
                Image(systemName: "chevron.down")
                    .font(.footnote)
            }

            Spacer()

            Button {
                self.isShowingForm.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .buttonStyle(.borderless)
        }
        .font(.headline)
        .foregroundStyle(.cellTitle)
        .padding()
        .sheet(isPresented: self.$isShowingForm) {
            ProjectForm()
        }
    }
}

#Preview {
    ProjectHeaderView()
        .background(.listBackground)
}
