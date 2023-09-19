//
//  ContentCellViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ContentCellViewRepresentation {
    var backgroundColor: UIColor = .background
    var selectedBackgroundColor: UIColor = .contentCellSelectedBackground

    var titleColor: UIColor = .contentCellTitle
    var titleFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var themeColor: UIColor = .contentCellTheme
    var themeFont: UIFont = .systemFont(ofSize: 12, weight: .regular)

    var separatorColor: UIColor = .contentCellSeparator
    var separatorHeight: CGFloat = 1

    var typeImageTintColor: UIColor = .contentCellTypeImageTint
    var typeImageSize: CGFloat = 25
    func typeImage(with systemName: String?) -> UIImage? {
        guard let systemName else { return nil }
        return UIImage(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(scale: .small)
        )
    }
}
