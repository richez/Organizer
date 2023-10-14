//
//  FormTextField.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct FormTextField: View {
    var configuration: Configuration
    @Binding var text: String
    @Binding var isInvalid: Bool
    @FocusState.Binding var focusedField: Name?

    var body: some View {
        TextField(self.configuration.placeholder, text: self.$text)
            .foregroundStyle(.black)
            .focused(self.$focusedField, equals: self.configuration.name)
            .submitLabel(self.configuration.submitLabel)
            .onChange(of: self.focusedField) {
                if self.focusedField == self.configuration.name {
                    self.isInvalid = false
                }
            }

        if self.isInvalid {
            Text(self.configuration.errorMessage)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    Form {
        FormTextField(
            configuration: PreviewData.previewConfiguration,
            text: .constant(""),
            isInvalid: .constant(true),
            focusedField: PreviewData.$focus
        )
    }
    .background(Color.listBackground)
    .scrollContentBackground(.hidden)
}

private enum PreviewData {
    static var previewConfiguration: FormTextField.Configuration {
        .init(
            name: .title,
            placeholder: "Your project",
            submitLabel: .return,
            errorMessage: "The field cannot be empty"
        )
    }

    @FocusState static var focus: FormTextField.Name?
}
