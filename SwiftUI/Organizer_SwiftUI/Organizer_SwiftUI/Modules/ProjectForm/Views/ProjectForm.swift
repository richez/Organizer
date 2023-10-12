//
//  ProjectForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectForm: View {
    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var theme: String = ""
    @State private var isInvalidTitle: Bool = false
    @State private var isInvalidTheme: Bool = false
    @FocusState private var focusedField: FormTextField.Name?

    @State private var isShowingErrorAlert: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormTextField(
                    configuration: self.viewModel.titleConfiguration,
                    text: self.$title,
                    isInvalid: self.$isInvalidTitle,
                    focusedField: self.$focusedField
                )
                FormTextField(
                    configuration: self.viewModel.themeConfiguration,
                    text: self.$theme,
                    isInvalid: self.$isInvalidTheme,
                    focusedField: self.$focusedField
                )
            }
            .onSubmit {
                self.focusedField = self.viewModel.field(after: self.focusedField)
            }

            FloatingButton(systemName: "checkmark") {
                self.commit()
            }
            .alert("An unknown error occured", isPresented: self.$isShowingErrorAlert) {
            } message: {
                Text("Please try again later")
            }
        }
        .padding(.top)
        .background(Color.listBackground)
    }
}

private extension ProjectForm {
    var values: ProjectForm.Values {
        .init(title: self.title, theme: self.theme)
    }

    func commit() {
        do {
            self.focusedField = nil
            try self.viewModel.commit(self.values, in: self.modelContext)
            self.dismiss()
        } catch ViewModel.Error.invalidFields(let fields) {
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
        } catch {
            self.isShowingErrorAlert = true
        }
    }
}

#Preview {
    ProjectForm()
        .scrollContentBackground(.hidden)
        .previewModelContainer()
}
