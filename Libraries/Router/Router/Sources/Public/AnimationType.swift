//
//  AnimationType.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 25/12/22.
//

import Foundation
import Hero

public enum AnimationType {
    case push(direction: HeroDefaultAnimationType.Direction)
    case pull(direction: HeroDefaultAnimationType.Direction)
    case cover(direction: HeroDefaultAnimationType.Direction)
    case uncover(direction: HeroDefaultAnimationType.Direction)
    case pageIn(direction: HeroDefaultAnimationType.Direction)
    case pageOut(direction: HeroDefaultAnimationType.Direction)
    case slide(direction: HeroDefaultAnimationType.Direction)
    case zoomSlide(direction: HeroDefaultAnimationType.Direction)
    case fade
    case bottomSheet
    case bottomSheetViewController
    
    indirect case autoReverse(presentAnimation: AnimationType)
    indirect case differentAnimation(presentAnimation: AnimationType, dismissAnimation: AnimationType)
}
