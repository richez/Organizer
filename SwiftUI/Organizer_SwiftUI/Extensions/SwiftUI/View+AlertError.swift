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
        self.underlyingError?.errorDescription ?? String(localized: "An unknown error occured")
    }

    var recoverySuggestion: String? {
        self.underlyingError?.recoverySuggestion ?? String(localized: "Please try again later")
    }

    init?(error: Error?) {
        guard let error else { return nil }
        self.underlyingError = error as? LocalizedError
    }
}

extension View {
    /// Presents an alert with a message when the binded error is not `nil`.
    ///
    /// - Parameters:
    ///   - error: A binding to an `Error` value that determines whether to
    ///     present the alert. When the user select the alert action, the
    ///     error is set to `nil` and the alert is dismissed
    ///
    /// If the binded error conforms to `LocalizedError`, the `errorDescription` is used
    /// for the alert's title and the `recoverySuggestion` for the alert's message. Otherwise,
    /// default values are provided (cf ``LocalizedAlertError``)
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
