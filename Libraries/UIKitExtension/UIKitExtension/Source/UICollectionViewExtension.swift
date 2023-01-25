//
//  UICollectionViewExtension.swift
//  UIKitExtension
//
//  Created by Rio Rizky Rainey Ferbiansyah on 22/12/22.
//

import Foundation
import UIKit

public extension UICollectionView {
    public func register(_ keys: String){
        let nib = UINib(nibName: keys, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: keys)
    }
}
