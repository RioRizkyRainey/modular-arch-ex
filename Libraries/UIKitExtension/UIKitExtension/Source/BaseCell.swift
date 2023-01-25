//
//  BaseCell.swift
//  UIKitExtension
//
//  Created by Rio Rizky Rainey Ferbiansyah on 21/12/22.
//

import Foundation

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

}
