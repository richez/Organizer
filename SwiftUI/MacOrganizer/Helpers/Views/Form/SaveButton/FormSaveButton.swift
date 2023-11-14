//
//  FormSaveButton.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct FormSaveButton: View {
    let action: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            Button("Cancel", role: .cancel) {
                self.dismiss()
            }
            Spacer()
            Button("Save") {
                self.action()
            }
        }
        .buttonStyle(.link)
    }
}

#Preview {
    Form {
        FormSaveButton { }
    }
    .frame(height: 100)
}
