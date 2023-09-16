//
//  ProjectContentListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

final class ProjectContentListViewModel {
    private let project: Project
    private let notificationCenter: NotificationCenter
    private var settings: ProjectContentListSettings

    init(project: Project,
         settings: ProjectContentListSettings = .init(),
         notificationCenter: NotificationCenter = .default) {
        self.project = project
        self.settings = settings
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ProjectContentListViewModel {
    // MARK: - Properties

    var navigationBarTitle: String { self.project.title }
    var rightBarImageName: String { "ellipsis" }
    var section: ProjectContentSection { .main }

    // MARK: Data

    func fetchContentDescriptions() throws -> [ProjectContentDescription] {
        do {
            return try self.project.contents
                .filter(self.predicate)
                .sorted(using: self.sortDescriptor)
                .map { content in
                    ProjectContentDescription(
                        id: content.id,
                        typeImageName: self.imageName(for: content.type),
                        title: content.title,
                        theme: self.theme(for: content)
                    )
                }
        } catch {
            throw ProjectContentListViewModelError.fetch(error)
        }
    }

    func deleteContent(with id: UUID) throws {
        guard let index = self.project.contents.firstIndex(where: { $0.id == id }) else {
            throw ProjectContentListViewModelError.delete(id)
        }

        self.project.contents.remove(at: index)
        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProjectContent, object: nil)
    }

    // MARK: Menu

    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let content = try? self.project.contents.filter(self.predicate)
        return .init(
            title: "content".pluralize(count: content?.count ?? 0) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(content: content, handler: handler),
                self.typeMenuConfig(handler: handler)
            ]
        )
    }
}

// MARK: - Helpers

private extension ProjectContentListViewModel {
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

    func themeMenuConfig(content: [ProjectContent]?, handler: @escaping () -> Void) -> MenuConfiguration {
        let existingThemes = content?.lazy.flatMap(\.themes) ?? [] // TODO: remove duplicate
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
            ] + existingThemes.map { theme in
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
