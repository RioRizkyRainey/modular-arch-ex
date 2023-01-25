//
//  Coordinator.swift
//  Router
//
//  Created by Rio Rizky Rainey Ferbiansyah on 08/01/23.
//

import Foundation
import UIKit

internal class Coordinator {
    var engine: NavigatorSpecs = Navigator()
    var screenConfiguration: ((ScreenConfig) -> Void)? = nil
    var props: Any? = nil
    
    func updateContext(from viewController: UIViewController) {
        engine.navigationController = viewController.navigationController
        engine.viewController = viewController
    }
    
    func sendProps(data: Any?, to screenPath: String?) {
        self.props = data
        
        guard let props = props, let screenPath = screenPath else { return }
        PropsMemory.shared.insert(path: screenPath, data: props)
        self.props = nil
    }
    
    func initialize(window: UIWindow, screenPath: String) {
        sendProps(data: props, to: screenPath)
        execute(screenPath: screenPath, navigation: .present) { [weak self] screenConfig in
            guard let self = self else { return }
            guard let screenConfig = screenConfig,
                  let viewController = screenConfig.viewController else { return }
            
            self.screenConfiguration?(screenConfig)
            self.screenConfiguration = nil
            
            if screenConfig.insideNavigationVc {
                let navigationController = UIHelper.setupNavigationController(rootVc: viewController)
                window.rootViewController = navigationController
                self.engine.navigationController = navigationController
                self.engine.viewController = screenConfig.viewController
            } else {
                window.rootViewController = screenConfig.viewController
                self.engine.viewController = screenConfig.viewController
            }
        }
    }
    
    func switchRoot(screenPath: String?, animated: Bool = true, completion: (() -> Void)? = nil) {
        sendProps(data: props, to: screenPath)
        execute(screenPath: screenPath, navigation: .present) { [weak self] screenConfig in
            guard let self = self else { return }
            guard let screenConfig = screenConfig,
                  let viewController = screenConfig.viewController else { return }
            
            self.screenConfiguration?(screenConfig)
            self.screenConfiguration = nil
            
            if screenConfig.insideNavigationVc {
                let navigationController = UIHelper.setupNavigationController(rootVc: viewController)
                self.engine.navigationController = navigationController
                self.engine.viewController = viewController
                self.engine.switchRoot(navigationController, animated: animated, completion: completion)
            } else {
                self.engine.navigationController = nil
                self.engine.viewController = viewController
                self.engine.switchRoot(viewController, animated: animated, completion: completion)
            }
        }
    }
    
    func present(screenPath: String?, screenConfig: ScreenConfig, animationType: AnimationType? = nil, completion: (() -> Void)? = nil) {
        
        guard let viewController = screenConfig.viewController else { return }
        
        print("RGNavigation: Present to \(screenPath)")

        self.screenConfiguration?(screenConfig)
        
        if screenConfig.insideNavigationVc {
            let navigationController = UIHelper.setupNavigationController(rootVc: viewController)
            screenConfig.navigationController = navigationController
            screenConfig.viewController = viewController
            self.engine.navigationController = navigationController
            self.engine.viewController = viewController
            self.screenConfiguration?(screenConfig)
            self.screenConfiguration = nil
            
            self.engine.present(viewController: navigationController,
                                animationType: animationType ?? screenConfig.animationType,
                                completion: completion)
        } else {
            self.screenConfiguration?(screenConfig)
            self.screenConfiguration = nil
            
            self.engine.present(viewController: viewController,
                                animationType: animationType ?? screenConfig.animationType,
                                completion: completion)
        }
    }
    
    func push(screenPath: String?, screenConfig: ScreenConfig, animationType: AnimationType? = nil, completion: (() -> Void)? = nil) {
        guard let viewController = screenConfig.viewController else { return }
        print("RGNavigation: Push to \(screenPath)")
        
        self.screenConfiguration?(screenConfig)
        self.screenConfiguration = nil
        
        self.engine.push(
            viewController: viewController,
            animationType: animationType ?? screenConfig.animationType
        )
    }
    
    func pop(screenPath: String? = nil) {
        execute(screenPath: screenPath, navigation: .pop) { [weak self] screenConfig in
            guard let self = self else { return }
            
            if let screenConfig = screenConfig, let viewController = screenConfig.viewController {
                self.engine.pop(to: viewController)
            } else {
                self.engine.pop()
            }
            
        }
    }
    
    func dismiss(screenPath: String?, completion: (() -> Void)? = nil) {
        execute(screenPath: screenPath, navigation: .dismiss) { [weak self] _ in
            guard let self = self else { return }
            self.engine.dismiss(completion: completion)
        }
    }
    
    func popToRoot() {
        engine.popToRoot()
    }
    
    
    func initialize(navigationController: UINavigationController, screenPath: String) {
        sendProps(data: props, to: screenPath)
        execute(screenPath: screenPath, navigation: .present) { [weak self] screenConfig in
            guard let self = self else { return }
            guard let screenConfig = screenConfig,
                  let viewController = screenConfig.viewController else { return }
            
            self.sendData(self.data, to: screenPath)
            self.screenConfiguration?(screenConfig)
            self.screenConfiguration = nil
            
            self.engine.navigationController = navigationController
            self.engine.viewController = viewController
        }
    }
    
    private func execute(screenPath: String?,
                     navigation: Navigation?,
                     routerData: @escaping ((ScreenConfig?) -> Void)) {
            
            switch navigation {
            case .push, .present, nil:
                if let screenPath = screenPath {
                    if let module = SharedModuleRouter.moduleForURLPath(screenPath) {
                        if let config = ModuleHelper.createScreen(module, screenPath: screenPath) {
                            if let screen = config.screen {
                                let viewController = screen.viewController ?? ComponentHostingViewController(screen)
                                let navigationController = screen.navigationController
                                config.viewController = viewController
                                config.navigationController = navigationController
                                
                                if let navigation = navigation {
                                    config.presentation = navigation == .present ? .present : .push
                                }
                                
                                ModuleMemory.shared.insert(path: screenPath, module: module)
                                ScreenMemory.shared.insert(path: screenPath, screen: screen)
                                
                                if let screenConfig = handleAuthGuard(config: config, screenPath: screenPath),
                                   let authMetadata = RGNavigation.shared.authScreenMetadata {
                                    routerData(screenConfig)
                                    passEventCallback(screenPath: authMetadata.path)
                                } else {
                                    routerData(config)
                                    passEventCallback(screenPath: screenPath)
                                }
                                return
                            } else if let viewController = config.viewController {
                                config.viewController = viewController
                                config.navigationController = viewController.navigationController
                                
                                if let navigation = navigation {
                                    config.presentation = navigation == .present ? .present : .push
                                }
                                
                                ModuleMemory.shared.insert(path: screenPath, module: module)
                                ScreenMemory.shared.insert(path: screenPath, viewController: viewController)
                                
                                if let screenConfig = handleAuthGuard(config: config, screenPath: screenPath),
                                   let authMetadata = RGNavigation.shared.authScreenMetadata {
                                    routerData(screenConfig)
                                    passEventCallback(screenPath: authMetadata.path)
                                } else {
                                    routerData(config)
                                    passEventCallback(screenPath: screenPath)
                                }
                                return
                            }
                        } else if let screen = ModuleHelper.createModule(module, screenPath: screenPath) {
                            ModuleMemory.shared.insert(path: screenPath, module: module)
                            ScreenMemory.shared.insert(path: screenPath, screen: screen)
                            let viewController = screen.viewController ?? ComponentHostingViewController(screen)
                            let navigationController = screen.navigationController
                            let screenConfig = ScreenConfig(viewController: viewController,
                                                            navigationController: navigationController,
                                                            insideNavigationVc: false)
                            routerData(screenConfig)
                            return
                        }
                    }
                }
                print("RGNavigation Error: \(screenPath ?? "path") not found.")
            case .pop, .dismiss:
                if let screenPath = screenPath {
                    let screen = ScreenMemory.shared.getScreen(path: screenPath)
                    var viewController = screen?.viewController
                    if viewController == nil {
                        viewController = ScreenMemory.shared.getViewController(path: screenPath)
                    }
                    
                    let navigationController = viewController?.navigationController
                    let screenConfig = ScreenConfig(viewController: viewController,
                                                    navigationController: navigationController)
                    routerData(screenConfig)
                    
                    passEventCallback(screenPath: screenPath)
                    let module = ModuleMemory.shared.get(path: screenPath)
                    ModuleHelper.moduleCallback(module, screenPath: screenPath)
                } else {
                    routerData(nil)
                }
            default:
                routerData(nil)
            }
            
        }
    
    private func setupNavigationController(rootVc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootVc)
        navigationController.navigationBar.isTranslucent = false
        
        if #available(iOS 13.0, *) {
            let barColor: UIColor = .white
            let appearance = UINavigationBarAppearance()
            navigationController.navigationBar.barTintColor = barColor
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = barColor
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        }
        return navigationController
    }
}
