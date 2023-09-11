//
//  ProjectContentDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ProjectContentDataSourceDelegate: AnyObject {
    func didTapDelete(on contentDescription: ProjectContentDescription)
}

final class ProjectContentDataSource: UITableViewDiffableDataSource<ProjectContentSection, ProjectContentDescription> {
    // MARK: - Properties

    weak var delegate: ProjectContentDataSourceDelegate?

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


    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        switch editingStyle {
        case .delete:
            guard let contentDescription = self.itemIdentifier(for: indexPath) else { return }
            self.delegate?.didTapDelete(on: contentDescription)
        default:
            break
        }
    }
}

