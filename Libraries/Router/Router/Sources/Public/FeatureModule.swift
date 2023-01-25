//
//  RouterModule.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 25/12/22.
//

import Foundation

open class FeatureModule {
    
    required public init() {}
    
    open func moduleCallback(_ screenMetadata: ScreenMetadata) {}
    
    open func createDeeplink(_ screenMetadata: ScreenMetadata, queries: [String: Any]) -> ScreenConfig? {
        return nil
    }

    open func createScreen(_ screenMetadata: ScreenMetadata, properties: Any?) -> ScreenConfig? {
        return nil
    }
    
}
