//
//  RouteConfigSpecs.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 25/12/22.
//

import Foundation
import UIKit

public protocol RouteConfigSpecs {
    var screen: RouterWireframeInterface? { get set }
    var authGuard: Bool { get set }
    var presentation: PresentationMethod? { get set }
    var viewController: UIViewController? { get set }
    var navigationController: UINavigationController? { get set }
    var insideNavigationVc: Bool { get set }
    var animationType: AnimationType? { get set }
}

public enum PresentationMethod {
    case push
    case present
}
