//
//  ContentListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

final class ContentListViewModel {
    private let project: Project
    private let settings: ContentListSettings
    private let fetchDescriptor: ContentListFetchDescriptorProtocol
    private let menuConfigurator: ContentListMenuConfiguratorProtocol
    private let notificationCenter: NotificationCenter

    init(project: Project,
         settings: ContentListSettings,
         fetchDescriptor: ContentListFetchDescriptorProtocol,
         menuConfigurator: ContentListMenuConfiguratorProtocol,
         notificationCenter: NotificationCenter = .default) {
        self.project = project
        self.settings = settings
        self.fetchDescriptor = fetchDescriptor
        self.menuConfigurator = menuConfigurator
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ContentListViewModel {
    // MARK: - Properties

    var navigationBarTitle: String {
        switch (self.settings.selectedTheme, self.settings.selectedType) {
        case (.all, .all):
            return self.project.title
        case (.all, .custom(let selectedType)):
            return self.project.title + "\n\(selectedType.rawValue)s"
        case (.custom(let selectedTheme), .all):
            return self.project.title + "\n#\(selectedTheme)"
        case (.custom(let selectedTheme), .custom(let selectedType)):
            return self.project.title + "\n#\(selectedTheme) - \(selectedType.rawValue)s"
        }
    }
    var rightBarImageName: String { "ellipsis" }
    var section: ContentListSection { .main }

    var viewConfiguration: ContentListViewConfiguration {
        .init(
            createButtonImageName: "plus",
            swipeActions: [
                ContentListSwipeActionConfiguration(imageName: "trash", action: .delete),
                ContentListSwipeActionConfiguration(imageName: "square.and.pencil", action: .edit)
            ],
            contextMenuTitle: "",
            contextMenuActions: [
                ContentListContextMenuActionConfiguration(
                    title: "Open in Browser", imageName: "safari", action: .openBrowser
                ),
                ContentListContextMenuActionConfiguration(title: "Copy Link", imageName: "doc.on.doc", action: .copyLink),
                ContentListContextMenuActionConfiguration(title: "Edit", imageName: "square.and.pencil", action: .edit),
                ContentListContextMenuActionConfiguration(title: "Delete", imageName: "trash", action: .delete)
            ]
        )
    }

    // MARK: Data

    func fetchContentDescriptions() throws -> [ContentDescription] {
        do {
            return try self.project.contents
                .filter(self.fetchDescriptor.predicate)
                .sorted(using: self.fetchDescriptor.sortDescriptor)
                .map { content in
                    ContentDescription(
                        id: content.id,
                        typeImageName: self.imageName(for: content.type),
                        title: content.title,
                        theme: self.theme(for: content)
                    )
                }
        } catch {
            throw ContentListViewModelError.fetch(error)
        }
    }

    func content(with id: UUID) throws -> ProjectContent {
        guard let content = self.project.contents.first(where: { $0.id == id }) else {
            throw ContentListViewModelError.notFound(id)
        }

        return content
    }

    func contentURL(with id: UUID) throws -> URL {
        let contentLink = try self.content(with: id).link
        guard contentLink.isValidURL(), let url = URL(string: contentLink) else {
            throw ContentListViewModelError.badLink(contentLink)
        }
        return url
    }

    func deleteContent(with id: UUID) throws {
        guard let index = self.project.contents.firstIndex(where: { $0.id == id }) else {
            throw ContentListViewModelError.delete(id)
        }

        self.project.contents.remove(at: index)
        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProjectContent, object: nil)
    }

    // MARK: Menu

    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let numberOfContents = try? self.project.contents.filter(self.fetchDescriptor.predicate).count
        let allExistingThemes = self.project.contents.flatMap(\.themes).removingDuplicates()
        return self.menuConfigurator.configuration(
            numberOfContents: numberOfContents ?? 0,
            themes: allExistingThemes,
            handler: handler
        )
    }
}

// MARK: - Helpers

private extension ContentListViewModel {
    // MARK: Content

    func imageName(for contentType: ProjectContentType) -> String? {
        guard self.settings.showType else { return nil }

        switch contentType {
        case .article:
            return "newspaper"
        case .note:
            return "note"
        case .video:
            return "video"
        case .other:
            return "questionmark.square"
        }
    }

    func theme(for content: ProjectContent) -> String? {
        guard self.settings.showTheme else { return nil }
        return content.themes.map { "#\($0)" }.joined(separator: " ")
    }
}
