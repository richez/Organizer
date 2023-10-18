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
            Text("Projects")
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
            VStack(alignment: .leading, spacing: 20) {
                Button("Cancel", role: .cancel) {
                    self.isShowingForm = false
                }

                ProjectForm()
                    .frame(width: 500, height: 300)
            }
            .padding()
        }
    }
}

#Preview {
    ProjectHeaderView()
        .background(.listBackground)
}
