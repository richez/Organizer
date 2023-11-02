//
//  WidgetURL+Deeplink.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import SwiftUI

extension View {
    func widgetURL(_ deeplink: Deeplink) -> some View {
        self.widgetURL(deeplink.url)
    }
}
