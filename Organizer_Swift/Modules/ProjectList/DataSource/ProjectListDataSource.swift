//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

enum ProjectListDataSourceError: Error {
    case notFound(IndexPath)
}

final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectDescription> {
    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, projectDescription in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectCell.identifier,
                for: indexPath
            ) as! ProjectCell
            cell.configure(with: projectDescription)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(section: ProjectListSection,
                       projectDescriptions: [ProjectDescription],
                       animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(projectDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    func applySnapshot(deleting projectDescription: ProjectDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectDescription])
        self.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: - Getter

    func projectDescription(for indexPath: IndexPath) throws -> ProjectDescription {
        guard let projectDescription = self.itemIdentifier(for: indexPath) else {
            throw ProjectListDataSourceError.notFound(indexPath)
        }

        return projectDescription
    }
}
