//
//  ProjectListMenuConfigurator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 20/09/2023.
//

import Foundation

/// A type that conform to ``ProjectListMenuConfiguratorProtocol`` and use the ``ProjectListSettings``
/// values to compute the menu configuration.
struct ProjectListMenuConfigurator {
    let settings: ProjectListSettings
}

// MARK: - ProjectListMenuConfiguratorProtocol

extension ProjectListMenuConfigurator: ProjectListMenuConfiguratorProtocol {
    func configuration(numberOfProjects: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "project".pluralize(count: numberOfProjects) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(themes: themes, handler: handler)
            ]
        )
    }
}

// MARK: - Helpers

private extension ProjectListMenuConfigurator {
    // MARK: Sorting

    func sortingMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
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
                })
            ],
            submenus: [
                .init(displayInline: true,
                      items: [
                        .init(title: self.settings.sorting != .title ? "Newest on Top" : "A to Z",
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
                .init(title: "Statistics", isOn: self.settings.showStatistics, handler: {
                    self.settings.showStatistics.toggle()
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
}
