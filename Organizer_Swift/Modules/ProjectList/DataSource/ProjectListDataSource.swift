//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

/// A specialized `UITableViewDiffableDataSource` that handles ``ProjectListSection``and ``ProjectDescription``
/// to display a list of ``ProjectCell``.
final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectDescription> {
    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, projectDescription in
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.identifier, for: indexPath) as! ProjectCell
            cell.configure(with: projectDescription)
            return cell
        }
    }

    // MARK: - Snapshot


    /// Updates the UI to reflect the state of the specified data optionally animating the UI changes.
    func applySnapshot(section: ProjectListSection, projectDescriptions: [ProjectDescription], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(projectDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    /// Updates the UI to reflect the deletion of the specified ``ProjectDescription`` optionally animating
    /// the UI changes.
    func applySnapshot(deleting projectDescription: ProjectDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectDescription])
        self.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: - Getter

    /// Returns the ``ProjectDescription`` at the specified index path in the table view or throw a
    /// ``ProjectListDataSourceError/notFound(_:)`` error.
    func projectDescription(for indexPath: IndexPath) throws -> ProjectDescription {
        guard let projectDescription = self.itemIdentifier(for: indexPath) else {
            throw ProjectListDataSourceError.notFound(indexPath)
        }

        return projectDescription
    }
}
