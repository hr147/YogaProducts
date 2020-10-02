//
//  AppCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

final class AppCoordinator: BaseCoordinator<AppNavigationController> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: .init())
    }
    
    override func start() {
        let vc = ProductFactory().productViewController()
        rootViewController.pushViewController(vc, animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
