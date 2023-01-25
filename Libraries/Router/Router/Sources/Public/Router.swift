//
//  Router.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 08/01/23.
//

import Foundation
import UIKit

public class Router {
    
    /// Shared object to be used in the app
    public static let shared = Router()
    
    private var navigator: Coordinator? = nil
    
    init() {
        navigator = Coordinator()
    }
    
    /// Initialize starting route
    /// - Parameters:
    ///     - window: The backdrop for your app’s user interface and the object that dispatches events to your views.
    ///     - screenMetadata: Screen that will be used as root
    public func initialize(window: UIWindow, screenMetadata: ScreenMetadata) {
        navigator?.initialize(window: window, screenPath: screenMetadata.path)
    }
    
    public func initialize(navigationController: UINavigationController, screenMetadata: ScreenMetadata) {
        navigator?.initialize(navigationController: navigationController, screenPath: screenMetadata.path)
    }
}
