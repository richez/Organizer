//
//  FormLoadingButton.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import SwiftUI

struct FormLoadingButton: View {
    var title: String
    var isEnabled: Bool
    var isLoading: Bool
    let action: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(self.title) {
                self.action()
            }
            .foregroundStyle(self.foregroundStyle)
            .disabled(self.disabled)

            if self.isLoading {
                ProgressView()
            }
        }
    }
}

private extension FormLoadingButton {
    var foregroundStyle: Color {
        self.isEnabled ? .blue : .blue.opacity(0.2)
    }

    var disabled: Bool {
        !self.isEnabled && self.isLoading
    }
}

#Preview {
    FormLoadingButton(title: "Fetch", isEnabled: true, isLoading: true, action: {})
}
