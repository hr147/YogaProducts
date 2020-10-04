//
//  BaseCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit.UIViewController

class BaseCoordinator<T: UIViewController>: NSObject, Coordinator {
    let rootViewController: T
    
    /// A child flow coordinator started from this flow.
    var child: Coordinator?

    /// The parent flow coordinator that started this flow.
    weak var parent: Coordinator?
    
    //MARK: - init
    
    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    //MARK: - Public Methods
    
    func start() {
        assertionFailure("child class must override it.")
    }
}
