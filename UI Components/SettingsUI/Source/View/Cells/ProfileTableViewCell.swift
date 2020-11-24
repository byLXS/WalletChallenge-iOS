//
//  ProfileTableViewCell.swift
//  SettingsUI
//
//  Created by Robert on 22.11.2020.
//

import UIKit
import CommonUI
import RSThemeKit

class ProfileTableViewCell: ThemeTableCell, NibLoadable {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var telegramUsernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        userNameLabel.textColor = theme.textColor
        telegramUsernameLabel.textColor = theme.detailTextColor
        userImageView.tintColor = theme.tintColor
        backgroundColor = theme.cellBackgroundColor
    }
    
}
