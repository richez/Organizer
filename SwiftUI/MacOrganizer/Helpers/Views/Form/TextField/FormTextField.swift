//
//  FormTextField.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct FormTextField: View {
    var configuration: Configuration
    @Binding var text: String
    @Binding var isInvalid: Bool

    var body: some View {
        Group {
            LabeledContent(self.configuration.name) {
                TextField("", text: self.$text)
                    .foregroundStyle(.formTextfield)
            }

            Text(self.configuration.errorMessage)
                .foregroundStyle(.red)
                .padding(.leading, 5)
                .opacity(self.isInvalid ? 1 : 0)
        }
        .foregroundStyle(.white)
        .onChange(of: self.text) {
            self.isInvalid = false
        }
    }
}

#Preview {
    Form {
        FormTextField(
            configuration: .init(
                name: "Title", errorMessage: "This field is invalid"
            ),
            text: .constant(""),
            isInvalid: .constant(true)
        )
    }
    .background(.listBackground)
}
