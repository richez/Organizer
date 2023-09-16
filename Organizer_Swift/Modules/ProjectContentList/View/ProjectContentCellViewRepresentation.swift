//
//  ProjectContentCellViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ProjectContentCellViewRepresentation {
    var backgroundColor: UIColor = .clear
    var selectedBackgroundColor: UIColor = .projectContentCellSelectedBackground

    var titleColor: UIColor = .projectContentTitle
    var titleFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var themeColor: UIColor = .projectContentTheme
    var themeFont: UIFont = .systemFont(ofSize: 12, weight: .regular)

    var separatorColor: UIColor = .projectContentCellSeparator
    var separatorHeight: CGFloat = 1

    var typeImageTintColor: UIColor = .projectContentTypeImageTint
    var typeImageSize: CGFloat = 25
    func typeImage(with systemName: String) -> UIImage? {
        return UIImage(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(scale: .small)
        )
    }
}
