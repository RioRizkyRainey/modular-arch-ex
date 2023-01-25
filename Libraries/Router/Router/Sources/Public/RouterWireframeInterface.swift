//
//  NavigationWireframeInterface.swift
//  Navigation
//
//  Created by Rio Rizky Rainey Ferbiansyah on 18/12/22.
//

import Foundation
import UIKit

public protocol RouterWireframeInterface {
    var viewController: UIViewController { get }
    var navigationController: UINavigationController? { get }
}


open class BaseWireframe {

    private weak var _viewController: UIViewController?
    
    //to retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    public init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension BaseWireframe: RouterWireframeInterface {
    
    public var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController!
    }
    
    public var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

public extension UIViewController {
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

public extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true, hidesBottomBarWhenPushed: Bool = false) {
        let vc = wireframe.viewController
        vc.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        self.pushViewController(vc, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}
