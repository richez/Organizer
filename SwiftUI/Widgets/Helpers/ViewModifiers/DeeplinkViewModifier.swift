//
//  DeeplinkViewModifier.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import SwiftUI

struct DeeplinkViewModifier: ViewModifier {
    var deeplink: Deeplink

    func body(content: Content) -> some View {
        if let url = self.deeplink.url {
            Link(destination: url) { content }
        } else {
            content
        }
    }
}

extension View {
    func deeplink(_ deeplink: Deeplink) -> some View {
        self.modifier(DeeplinkViewModifier(deeplink: deeplink))
    }
}
