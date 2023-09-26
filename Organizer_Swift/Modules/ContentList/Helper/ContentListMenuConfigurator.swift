//
//  ContentListMenuConfigurator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

protocol ContentListMenuConfiguratorProtocol {
    func configuration(numberOfContents: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration
}

final class ContentListMenuConfigurator {
    // MARK: - Properties

    private let settings: ContentListSettings

    // MARK: - Initialization

    init(settings: ContentListSettings) {
        self.settings = settings
    }
}

// MARK: - ContentListMenuConfiguratorProtocol

extension ContentListMenuConfigurator: ContentListMenuConfiguratorProtocol {
    func configuration(numberOfContents: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "content".pluralize(count: numberOfContents) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(themes: themes, handler: handler),
                self.typeMenuConfig(handler: handler)
            ]
        )
    }
}

// MARK: - Sub Menus

private extension ContentListMenuConfigurator {
    // MARK: Sorting

    func sortingMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "List Sorting",
            imageName: "arrow.up.arrow.down",
            items: [
                .init(title: "Modification Date", isOn: self.settings.sorting == .lastUpdated, handler: { [weak self] in
                    if let self, self.settings.sorting != .lastUpdated {
                        self.settings.sorting = .lastUpdated
                        handler() // TODO: handler return bool to know if should update value
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

    // MARK: Preview Style

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

    // MARK: Theme

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

    // MARK: Type

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
                    .init(title: type.rawValue, isOn: self.settings.selectedType == .custom(type)) { [weak self] in
                        if let self, self.settings.selectedType != .custom(type) {
                            self.settings.selectedType = .custom(type)
                            handler()
                        }
                    }
            }
        )
    }
}
