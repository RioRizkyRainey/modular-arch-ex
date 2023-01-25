//
//  ScreenConfig.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 25/12/22.
//

import Foundation
import UIKit

public class ScreenConfig {
    public var screen: RouterWireframeInterface?
    public var authGuard: Bool
    public var presentation: PresentationMethod?
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public var insideNavigationVc: Bool
    public var animationType: AnimationType?
    
    public init(screen: RouterWireframeInterface,
                authGuard: Bool = false,
                presentation: PresentationMethod? = nil) {
        self.screen = screen
        self.authGuard = authGuard
        self.presentation = presentation
        self.viewController = screen.viewController
        self.navigationController = screen.navigationController
        self.insideNavigationVc = false
    }
    
    public init(screen: RouterWireframeInterface? = nil,
                authGuard: Bool = false,
                presentation: PresentationMethod? = nil,
                animationType: AnimationType? = nil,
                viewController: UIViewController? = nil,
                navigationController: UINavigationController? = nil,
                insideNavigationVc: Bool = false) {
        self.screen = screen
        self.authGuard = authGuard
        self.presentation = presentation
        self.animationType = animationType
        self.viewController = viewController ?? screen?.viewController
        self.navigationController = navigationController ?? screen?.navigationController
        self.insideNavigationVc = insideNavigationVc
    }

    public init(viewController: UIViewController?, navigationController: UINavigationController?, insideNavigationVc: Bool = false) {
        self.screen = nil
        self.authGuard = false
        self.presentation = nil
        self.viewController = viewController
        self.navigationController = navigationController
        self.insideNavigationVc = insideNavigationVc
    }
}
