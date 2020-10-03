//
//  SceneDelegate.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 01/10/2020.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK:- Public Properties
    
    var window: UIWindow?
    
    // MARK:- Private Properties
    
    private var coordinator: AppCoordinator?

    // MARK:- Public Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window)
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
    }
}

