//
//  UITableViewExtension.swift
//  Store
//
//  Created by Rio Rizky Rainey Ferbiansyah on 21/12/22.
//

import Foundation
import UIKit

public extension UITableView {

    open override var intrinsicContentSize: CGSize {
        return contentSize
    }

    public func register(_ keys: String){ //register table view cell
        let nib = UINib(nibName: keys, bundle: nil)
        self.register(nib, forCellReuseIdentifier: keys)
    }
}
