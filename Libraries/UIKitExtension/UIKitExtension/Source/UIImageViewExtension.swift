//
//  UIImageViewExtension.swift
//  UIKitExtension
//
//  Created by Rio Rizky Rainey Ferbiansyah on 22/12/22.
//

import Foundation
import SDWebImage

public extension UIImageView {
    public @IBInspectable var color: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue
        }
    }
    
    public func setImage(with urlString: String?, completed: SDExternalCompletionBlock? = nil) {
        if let urlString = urlString?.urlEncoded {
            self.sd_setImage(with: URL(string: urlString), completed: completed)
        }
    }
}
