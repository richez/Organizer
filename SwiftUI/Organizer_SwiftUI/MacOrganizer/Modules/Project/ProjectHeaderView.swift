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
            Menu {
                ProjectListSortingMenu()
                ProjectListPreviewStyleMenu()
            } label: {
                Text("Projects")
                    .font(.system(size: 15, weight: .heavy))
            }
            .menuStyle(.borderlessButton)
            .fixedSize(horizontal: true, vertical: false)
            .tint(.cellTitle)

            Spacer()

            Button {
                self.isShowingForm.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .buttonStyle(.borderless)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .padding([.leading, .trailing])
        .sheet(isPresented: self.$isShowingForm) {
            ProjectForm()
        }
    }
}

#Preview {
    ProjectHeaderView()
        .background(.listBackground)
}
