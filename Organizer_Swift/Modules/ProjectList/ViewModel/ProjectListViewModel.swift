//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class ProjectListViewModel {
    // MARK: - Properties

    private let dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter
    private var settings: ProjectListSettings

    // MARK: - Initialization

    init(dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter = ProjectDataStore.shared,
         settings: ProjectListSettings = .init()) {
        self.dataStore = dataStore
        self.settings = settings
    }
}

// MARK: - Public

extension ProjectListViewModel {
    // MARK: Properties

    var navigationBarTitle: String {
        switch self.settings.selectedTheme {
        case .all:
            return "Projects"
        case .custom(let selectedTheme):
            return "Projects\n#\(selectedTheme)"
        }
    }

    var rightBarImageName: String { "ellipsis" }
    var section: ProjectListSection { .main }

    var viewConfiguration: ProjectListViewConfiguration {
        .init(
            createButtonImageName: "square.and.pencil",
            swipeActions: [
                ProjectListSwipeActionConfiguration(imageName: "trash", action: .delete),
                ProjectListSwipeActionConfiguration(imageName: "square.and.pencil", action: .edit)
            ],
            contextMenuTitle: "",
            contextMenuActions: [
                ProjectListContextMenuActionConfiguration(title: "Archive", imageName: "archivebox", action: .archive),
                ProjectListContextMenuActionConfiguration(title: "Edit", imageName: "square.and.pencil", action: .edit),
                ProjectListContextMenuActionConfiguration(title: "Delete", imageName: "trash", action: .delete)
            ]
        )
    }

    // MARK: Data

    func fetchProjectDescriptions() throws -> [ProjectDescription] {
        do {
            let projects = try self.dataStore.fetch(predicate: self.predicate, sortBy: self.sortDescriptor)
            return projects.map { project in
                return ProjectDescription(
                    id: project.id,
                    title: project.title,
                    theme: self.theme(for: project),
                    statistics: self.statistics(for: project),
                    lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
                )
            }
        } catch {
            throw ProjectListViewModelError.fetch(error)
        }
    }

    func project(with projectID: UUID?) throws -> Project {
        guard let projectID else { throw ProjectListViewModelError.notFound(nil) }

        do {
            return try self.dataStore.project(with: projectID)
        } catch {
            throw ProjectListViewModelError.notFound(error)
        }
    }

    func deleteProject(with id: UUID) throws {
        do {
            try self.dataStore.delete(projectID: id)
        } catch {
            throw ProjectListViewModelError.delete(error)
        }
    }

    // MARK: Menu

    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let numberOfProjects = (try? self.dataStore.fetchCount(predicate: self.predicate, sortBy: [])) ?? 0
        let allExistingThemes = try? self.dataStore
            .fetch(predicate: nil, sortBy: [])
            .flatMap(\.themes)
            .removingDuplicates()
        return .init(
            title: "project".pluralize(count: numberOfProjects) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(themes: allExistingThemes ?? [], handler: handler)
            ]
        )
    }
}

// MARK: - Helpers

private extension ProjectListViewModel {
    // MARK: Fetch

    var predicate: Predicate<Project>? {
        switch self.settings.selectedTheme {
        case .all:
            return nil
        case .custom(let selectedTheme):
            return #Predicate<Project> { $0.theme.contains(selectedTheme) }
        }
    }

    var sortDescriptor: [SortDescriptor<Project>] {
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
        }
    }

    // MARK: Project

    func theme(for project: Project) -> String? {
        guard self.settings.showTheme else { return nil }
        return project.themes.map { "#\($0)" }.joined(separator: " ")
    }

    func statistics(for project: Project) -> String? {
        guard self.settings.showStatistics,
                let contentStatistics = "content".pluralize(count: project.contents.count) else {
            return nil
        }

        let contentTypeStatistics = ProjectContentType.allCases.compactMap { type in
            let numberOfContent =  project.contents.lazy.filter { $0.type == type }.count
            return type.rawValue.pluralize(count: numberOfContent)
        }.joined(separator: ", ")

        return "\(contentStatistics) (\(contentTypeStatistics))"
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
                })
            ],
            submenus: [
                .init(displayInline: true,
                      items: [
                        .init(title: self.settings.sorting != .title ? "Newest on Top" : "A to Z",
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
                .init(title: "Statistics", isOn: self.settings.showStatistics, handler: { [weak self] in
                    self?.settings.showStatistics.toggle()
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
}
