//
//  AppCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

/// `AppCoordinator` is responsible to manage transition at windows level.
final class AppCoordinator: BaseCoordinator<AppNavigationController> {
    // MARK:- Private Properties
    
    private let window: UIWindow
    
    // MARK:- Init
    
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: .init())
    }
    
    // MARK:- Public Methods
    
    override func start() {
        let coordinator = ProductCoordinator(rootViewController: rootViewController)
        startChild(coordinator)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
