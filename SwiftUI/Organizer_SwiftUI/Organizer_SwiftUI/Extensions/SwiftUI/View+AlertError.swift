//
//  View+AlertError.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import SwiftUI

struct LocalizedAlertError: LocalizedError {
    var underlyingError: LocalizedError?

    var errorDescription: String? {
        self.underlyingError?.errorDescription ?? "An unknown error occured"
    }

    var recoverySuggestion: String? {
        self.underlyingError?.recoverySuggestion ?? "Please try again later"
    }

    init?(error: Error?) {
        guard let error else { return nil }
        self.underlyingError = error as? LocalizedError
    }
}

extension View {
    func errorAlert(_ error: Binding<Error?>) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return self.alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button("OK") {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
