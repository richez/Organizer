//
//  ContentListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

final class ContentListViewModel {
    private let project: Project
    private let notificationCenter: NotificationCenter
    private var settings: ContentListSettings

    init(project: Project,
         settings: ContentListSettings = .init(),
         notificationCenter: NotificationCenter = .default) {
        self.project = project
        self.settings = settings
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
                .filter(self.predicate)
                .sorted(using: self.sortDescriptor)
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
            throw ContentListViewModelError.delete(id)
        }

        return content
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
        let numberOfContents = (try? self.project.contents.filter(self.predicate).count) ?? 0
        let allExistingThemes = self.project.contents.flatMap(\.themes).removingDuplicates()
        return .init(
            title: "content".pluralize(count: numberOfContents) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(themes: allExistingThemes, handler: handler),
                self.typeMenuConfig(handler: handler)
            ]
        )
    }
}

// MARK: - Helpers

private extension ContentListViewModel {
    // MARK: Fetch

    var predicate: Predicate<ProjectContent>? {
        switch (self.settings.selectedTheme, self.settings.selectedType) {
        case (.all, .all):
            return nil
        case (.all, .custom(let selectedType)):
            return #Predicate<ProjectContent> { $0.type == selectedType }
        case (.custom(let selectedTheme), .all):
            return #Predicate<ProjectContent> { $0.theme.contains(selectedTheme) }
        case (.custom(let selectedTheme), .custom(let selectedType)):
            return #Predicate<ProjectContent> {
                $0.theme.contains(selectedTheme) && $0.type == selectedType
            }
        }
    }

    var sortDescriptor: [SortDescriptor<ProjectContent>] {
        switch self.settings.sorting {
        case .lastUpdated:
            let order: SortOrder = self.settings.ascendingOrder ? .reverse : .forward
            return [SortDescriptor(\.lastUpdatedDate, order: order)]
        case .creation:
            let order: SortOrder = self.settings.ascendingOrder ? .reverse : .forward
            return [SortDescriptor(\.creationDate, order: order)]
        case .title:
            let order: SortOrder = self.settings.ascendingOrder ? .forward : .reverse
            return [SortDescriptor(\.title, order: order)]
        case .type:
            let order: SortOrder = self.settings.ascendingOrder ? .forward : .reverse
            return [SortDescriptor(\.type.rawValue, order: order)]
        }
    }

    // MARK: Project Content

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

    // MARK: Menu

    func sortingMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "List Sorting",
            imageName: "arrow.up.arrow.down",
            items: [
                .init(title: "Modification Date", isOn: self.settings.sorting == .lastUpdated, handler: { [weak self] in
                    if let self, self.settings.sorting != .lastUpdated {
                        self.settings.sorting = .lastUpdated
                        handler()
                    }
                }),
                .init(title: "Creation Date", isOn: self.settings.sorting == .creation, handler: { [weak self] in
                    if let self, self.settings.sorting != .creation {
                        self.settings.sorting = .creation
                        handler()
                    }
                }),
                .init(title: "Title", isOn: self.settings.sorting == .title, handler: { [weak self] in
                    if let self, self.settings.sorting != .title {
                        self.settings.sorting = .title
                        handler()
                    }
                }),
                .init(title: "Type", isOn: self.settings.sorting == .type, handler: { [weak self] in
                    if let self, self.settings.sorting != .type {
                        self.settings.sorting = .type
                        handler()
                    }
                })

            ],
            submenus: [
                .init(displayInline: true,
                      items: [
                        .init(title: (self.settings.sorting != .title && self.settings.sorting != .type) ? "Newest on Top" : "A to Z",
                              isOn: self.settings.ascendingOrder,
                              handler: { [weak self] in
                                  self?.settings.ascendingOrder.toggle()
                                  handler()
                              })
                      ])
            ]
        )
    }

    func previewStyleMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "Preview Style",
            imageName: "text.alignleft",
            items: [
                .init(title: "Themes", isOn: self.settings.showTheme, handler: { [weak self] in
                    self?.settings.showTheme.toggle()
                    handler()
                }),
                .init(title: "Type", isOn: self.settings.showType, handler: { [weak self] in
                    self?.settings.showType.toggle()
                    handler()
                })
            ]
        )
    }

    func themeMenuConfig(themes: [String], handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "Themes",
            imageName: "number",
            singleSelection: true,
            items: [
                .init(title: "All", isOn: self.settings.selectedTheme == .all, handler: { [weak self] in
                    if let self, self.settings.selectedTheme != .all {
                        self.settings.selectedTheme = .all
                        handler()
                    }
                })
            ] + themes.map { theme in
                    .init(title: theme, isOn: self.settings.selectedTheme == .custom(theme)) { [weak self] in
                        if let self, self.settings.selectedTheme != .custom(theme) {
                            self.settings.selectedTheme = .custom(theme)
                            handler()
                        }
                    }
            }
        )
    }

    func typeMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "Type",
            imageName: "tray.full",
            singleSelection: true,
            items: [
                .init(title: "All", isOn: self.settings.selectedType == .all, handler: { [weak self] in
                    if let self, self.settings.selectedType != .all {
                        self.settings.selectedType = .all
                        handler()
                    }
                })
            ] + ProjectContentType.allCases.map { type in
                    .init(title: type.rawValue.capitalized, isOn: self.settings.selectedType == .custom(type)) { [weak self] in
                        if let self, self.settings.selectedType != .custom(type) {
                            self.settings.selectedType = .custom(type)
                            handler()
                        }
                    }
            }
        )
    }
}
