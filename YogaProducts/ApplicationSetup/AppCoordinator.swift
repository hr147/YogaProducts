//
//  AppCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

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
        let factory = ServiceLocator.productViewControllersFactory()
        let productViewController = factory.makeProductViewController()
        rootViewController.pushViewController(productViewController, animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
