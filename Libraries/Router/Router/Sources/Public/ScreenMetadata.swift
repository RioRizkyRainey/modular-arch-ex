//
//  ScreenMetadata.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 07/01/23.
//

import Foundation

public protocol ScreenMetadata {
    
    var deeplink: String? { get }
    
    var path: String { get }
    
}
