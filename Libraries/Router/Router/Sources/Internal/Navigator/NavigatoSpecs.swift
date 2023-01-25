//
//  Navigator.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 08/01/23.
//

import Foundation
import UIKit

internal protocol NavigatorSpecs {
    var navigationController: UINavigationController? { get set }
    var viewController: UIViewController? { get set }
    
    func push(viewController: UIViewController, animationType: AnimationType?)
    
    func pop()
    
    func pop(to viewController: UIViewController)
    
    func popToRoot()
    
    func present(viewController: UIViewController, animationType: AnimationType?, completion: (() -> Void)?)
    
    func dismiss(completion: (() -> Void)?)
    
    func switchRoot(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
}
