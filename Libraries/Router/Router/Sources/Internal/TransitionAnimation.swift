//
//  TransitionAnimation.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 08/01/23.
//

import Foundation
import UIKit
import Hero

internal class TransitionAnimation {
    func assignTransitionAnimation(navigationController: UINavigationController? = nil, viewController: UIViewController? = nil, animationType: AnimationType? = nil) {
        guard let transitionAnimationType = animationType else {
            if let navCon = navigationController {
                assignNavigationTransitionAnimation(navigationController: navCon, transitionAnimationType: .autoReverse(presentAnimation: .pull(direction: .left)))
            }
            return
        }
        
        if let navCon = navigationController {
            assignNavigationTransitionAnimation(navigationController: navCon, transitionAnimationType: transitionAnimationType)
        } else if let viCon = viewController {
            assignModalTransitionAnimation(viewController: viCon, transitionAnimationType: transitionAnimationType)
        }
    }
    
    private func assignNavigationTransitionAnimation(navigationController: UINavigationController, transitionAnimationType: AnimationType) {
        navigationController.hero.isEnabled = true
        
        guard let animationType = processTransitionAnimationType(transitionAnimationType: transitionAnimationType) else { return }
        navigationController.hero.navigationAnimationType = animationType
    }
    
    private func assignModalTransitionAnimation(viewController: UIViewController, transitionAnimationType: AnimationType) {
        viewController.hero.isEnabled = true
        
        guard let animationType = processTransitionAnimationType(transitionAnimationType: transitionAnimationType) else { return }
        viewController.hero.modalAnimationType = animationType
    }
    
    private func processTransitionAnimationType(transitionAnimationType: AnimationType) -> HeroDefaultAnimationType? {
        switch transitionAnimationType {
        case .push(let direction):
            return .push(direction: direction)
        case .pull(let direction):
            return .pull(direction: direction)
        case .cover(direction: let direction):
            return .cover(direction: direction)
        case .uncover(direction: let direction):
            return .uncover(direction: direction)
        case .pageIn(direction: let direction):
            return .pageIn(direction: direction)
        case .pageOut(direction: let direction):
            return .pageOut(direction: direction)
        case .slide(direction: let direction):
            return .slide(direction: direction)
        case .zoomSlide(direction: let direction):
            return .zoomSlide(direction: direction)
        case .fade:
            return .fade
        case .autoReverse(let kind):
            if let animationType = processTransitionAnimationType(transitionAnimationType: kind) {
                return .autoReverse(
                    presenting: animationType
                )
            }
            
            return nil
        case .differentAnimation(let presentAnimation, let dismissAnimation):
            if let presentingAnimation = processTransitionAnimationType(transitionAnimationType: presentAnimation),
               let dismissingAnimation = processTransitionAnimationType(transitionAnimationType: dismissAnimation) {
                return .selectBy(
                    presenting: presentingAnimation,
                    dismissing: dismissingAnimation
                )
            }
            
            return nil
        case .bottomSheet:
            return nil
        case .bottomSheetViewController:
            return nil
        }
    }
}
