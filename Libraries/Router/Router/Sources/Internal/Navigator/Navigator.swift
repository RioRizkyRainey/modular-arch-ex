//
//  Navigator.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 08/01/23.
//

import Foundation
import UIKit

internal class Navigator: NavigatorSpecs {
    
    var navigationController: UINavigationController? = nil
    var viewController: UIViewController? = nil
    
    let transitionAnimation = TransitionAnimation()
    
    // TODO: Add documentation
    func push(viewController: UIViewController, animationType: AnimationType?) {
        navigationController = UIApplication.getTopViewController()?.navigationController
        self.transitionAnimation.assignTransitionAnimation(
            navigationController: navigationController,
            animationType: animationType
        )
        
        navigationController?.pushViewController(viewController, animated: true)
        self.viewController = viewController
    }

    // TODO: Add documentation
    func pop() {
        navigationController = UIApplication.getTopViewController()?.navigationController
        navigationController?.popViewController(animated: true)
    }
    
    func pop(to viewController: UIViewController) {
        navigationController = UIApplication.getTopViewController()?.navigationController
        
        if let viewControllers = navigationController?.viewControllers, viewControllers.contains(viewController) {
            navigationController?.popToViewController(viewController, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func popToRoot() {
        navigationController = UIApplication.getTopViewController()?.navigationController
        navigationController?.popToRootViewController(animated: true)
    }

    // TODO: Add documentation
    func present(viewController: UIViewController, animationType: AnimationType?, completion: (() -> Void)?) {
        
        let currentVC = UIApplication.getTopViewController()
        
        
        switch animationType {
        case .bottomSheet:
            self.transitionAnimation.assignTransitionAnimation(
                viewController: viewController,
                animationType: nil
            )
            viewController.modalPresentationStyle = .overFullScreen
            currentVC?.present(viewController, animated: false, completion: completion)
        case .bottomSheetViewController:
            self.transitionAnimation.assignTransitionAnimation(
                viewController: viewController,
                animationType: nil
            )
            currentVC?.present(viewController, animated: true, completion: completion)
        default:
            self.transitionAnimation.assignTransitionAnimation(
                viewController: viewController,
                animationType: animationType
            )
            currentVC?.present(viewController, animated: true, completion: completion)
        }
        
        self.viewController = viewController
        
    }

    // TODO: Add documentation
    func dismiss(completion: (() -> Void)?) {
        let currentVC = UIApplication.getTopViewController()
        currentVC?.dismiss(animated: true, completion: completion)
    }
    
    func switchRoot(_ viewController: UIViewController,  animated: Bool = true, completion: (() -> Void)? = nil) {
        guard animated else {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            completion?()
            return
        }
        
        guard let window = UIApplication.shared.keyWindow else {
            completion?()
            return
        }
        
        UIView.transition(with: window, duration: 0.2, options: .curveEaseIn, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
    
}

private extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        return base
    }
}
