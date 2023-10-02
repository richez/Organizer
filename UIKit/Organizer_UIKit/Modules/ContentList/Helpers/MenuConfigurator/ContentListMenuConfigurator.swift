//
//  ContentListMenuConfigurator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

struct ContentListMenuConfigurator {
    let settings: ContentListSettings
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

// MARK: - Helpers

private extension ContentListMenuConfigurator {
    // MARK: Sorting

    func sortingMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "List Sorting",
            imageName: "arrow.up.arrow.down",
            items: [
                .init(title: "Modification Date", isOn: self.settings.sorting == .lastUpdated, handler: {
                    if self.settings.sorting != .lastUpdated {
                        self.settings.sorting = .lastUpdated
                        handler()
                    }
                }),
                .init(title: "Creation Date", isOn: self.settings.sorting == .creation, handler: {
                    if self.settings.sorting != .creation {
                        self.settings.sorting = .creation
                        handler()
                    }
                }),
                .init(title: "Title", isOn: self.settings.sorting == .title, handler: {
                    if self.settings.sorting != .title {
                        self.settings.sorting = .title
                        handler()
                    }
                }),
                .init(title: "Type", isOn: self.settings.sorting == .type, handler: {
                    if self.settings.sorting != .type {
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
                              handler: {
                                  self.settings.ascendingOrder.toggle()
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
                .init(title: "Themes", isOn: self.settings.showTheme, handler: {
                    self.settings.showTheme.toggle()
                    handler()
                }),
                .init(title: "Type", isOn: self.settings.showType, handler: {
                    self.settings.showType.toggle()
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
                .init(title: "All", isOn: self.settings.selectedTheme == .all, handler: {
                    if self.settings.selectedTheme != .all {
                        self.settings.selectedTheme = .all
                        handler()
                    }
                })
            ] + themes.map { theme in
                    .init(title: theme, isOn: self.settings.selectedTheme == .custom(theme)) {
                        if self.settings.selectedTheme != .custom(theme) {
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
                .init(title: "All", isOn: self.settings.selectedType == .all, handler: {
                    if self.settings.selectedType != .all {
                        self.settings.selectedType = .all
                        handler()
                    }
                })
            ] + ProjectContentType.allCases.map { type in
                    .init(title: type.rawValue, isOn: self.settings.selectedType == .custom(type)) {
                        if self.settings.selectedType != .custom(type) {
                            self.settings.selectedType = .custom(type)
                            handler()
                        }
                    }
            }
        )
    }
}
