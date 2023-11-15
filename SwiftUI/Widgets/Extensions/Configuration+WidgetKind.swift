//
//  Configuration+WidgetKind.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 15/11/2023.
//

import SwiftUI
import WidgetKit

extension StaticConfiguration {
    init<Provider>(
        kind: WidgetKind,
        provider: Provider,
        @ViewBuilder content: @escaping (Provider.Entry) -> Content
    ) where Provider : TimelineProvider {
        self.init(kind: kind.rawValue, provider: provider, content: content)
    }
}

extension AppIntentConfiguration {
    init<Provider>(
        kind: WidgetKind,
        intent: Intent.Type = Intent.self,
        provider: Provider,
        @ViewBuilder content: @escaping (Provider.Entry) -> Content
    ) where Intent == Provider.Intent, Provider : AppIntentTimelineProvider {
        self.init(kind: kind.rawValue, intent: intent, provider: provider, content: content)
    }
}

extension WidgetConfiguration {
    func configurationDisplayName(for kind: WidgetKind) -> some WidgetConfiguration {
        self.configurationDisplayName(kind.displayName)
    }

    func description(for kind: WidgetKind) -> some WidgetConfiguration {
        self.description(kind.description)
    }
}
