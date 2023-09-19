//
//  ContentListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

enum ContentListDataSourceError: Error {
    case notFound(IndexPath)
}

final class ContentListDataSource: UITableViewDiffableDataSource<ContentListSection, ContentDescription> {
    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, contentDescription in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ContentCell.identifier,
                for: indexPath
            ) as! ContentCell
            cell.configure(with: contentDescription)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(section: ContentListSection,
                       contentDescriptions: [ContentDescription],
                       animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ContentListSection, ContentDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(contentDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    func applySnapshot(deleting contentDescription: ContentDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([contentDescription])
        self.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: - Getter

    func contentDescription(for indexPath: IndexPath) throws -> ContentDescription {
        guard let contentDescription = self.itemIdentifier(for: indexPath) else {
            throw ContentListDataSourceError.notFound(indexPath)
        }

        return contentDescription
    }
}

