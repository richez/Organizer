//
//  Deeplink.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

/// Values that define the app supported deeplinks that can
/// be initialized from an `URL`.
///
/// The provided `URL` must be one of the below format:
///    - organizerapp://home
///    - organizerapp://open-project-form
///    - organizerapp://open-project?identifier=xxx
///    - organizerapp://open-content?identifier=xxx&projectIdentifier=xxx
enum Deeplink {
    case home
    case projectForm
    case project(id: String)
    case content(id: String, projectID: String)

    init?(url: URL) {
        guard
            url.scheme == Deeplink.scheme,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let host = Host(host: components.host)
        else {
            return nil
        }

        switch host {
        case .home:
            self = .home
        case .projectForm:
            self = .projectForm
        case .project:
            guard let identifier = components.queryItems?.item(named: .identifier) else { return nil }
            self = .project(id: identifier)
        case .content:
            guard let identifier = components.queryItems?.item(named: .identifier) else { return nil }
            guard let projectID = components.queryItems?.item(named: .projectIdentifier) else { return nil }
            self = .content(id: identifier, projectID: projectID)
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = Deeplink.scheme
        components.host = self.host.rawValue
        components.queryItems = self.queryItems
        return components.url
    }
}

fileprivate extension Deeplink {
    static let scheme: String = "organizerapp"

    enum Host: String {
        case home = "home"
        case projectForm = "open-project-form"
        case project = "open-project"
        case content = "open-content"

        init?(host: String?) {
            switch host {
            case .some(let value):
                self.init(rawValue: value)
            case .none:
                return nil
            }
        }
    }

    var host: Host {
        switch self {
        case .home: .home
        case .projectForm: .projectForm
        case .project: .project
        case .content: .content
        }
    }

    enum QueryItem: String {
        case identifier
        case projectIdentifier
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .home:
            return nil
        case .projectForm:
            return nil
        case .project(let id):
            return [.init(name: .identifier, value: id)]
        case .content(let id, let projectID):
            return [.init(name: .identifier, value: id), .init(name: .projectIdentifier, value: projectID)]
        }
    }
}

private extension URLQueryItem {
    init(name: Deeplink.QueryItem, value: String) {
        self.init(name: name.rawValue, value: value)
    }
}

private extension Sequence where Element == URLQueryItem {
    func item(named name: Deeplink.QueryItem) -> String? {
        guard
            let value = self.first(where: { $0.name == name.rawValue })?.value,
            !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return nil
        }
        return value
    }
}
