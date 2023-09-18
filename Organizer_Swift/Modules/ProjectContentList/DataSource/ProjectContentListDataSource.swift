//
//  ProjectContentListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

enum ProjectContentListDataSourceError: Error {
    case notFound(IndexPath)
}

final class ProjectContentListDataSource: UITableViewDiffableDataSource<ProjectContentSection, ProjectContentDescription> {
    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectContentCell.self, forCellReuseIdentifier: ProjectContentCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, contentDescription in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectContentCell.identifier,
                for: indexPath
            ) as! ProjectContentCell
            cell.configure(with: contentDescription)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(section: ProjectContentSection,
                       contentDescriptions: [ProjectContentDescription],
                       animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectContentSection, ProjectContentDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(contentDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    func applySnapshot(deleting contentDescription: ProjectContentDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([contentDescription])
        self.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: - Getter

    func contentDescription(for indexPath: IndexPath) throws -> ProjectContentDescription {
        guard let contentDescription = self.itemIdentifier(for: indexPath) else {
            throw ProjectContentListDataSourceError.notFound(indexPath)
        }

        return contentDescription
    }
}

