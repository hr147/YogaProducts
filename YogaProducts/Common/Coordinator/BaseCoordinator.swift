//
//  BaseCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit.UIViewController

class BaseCoordinator<T: UIViewController>: Coordinator {
    let rootViewController: T
    
    /// A child flow coordinator started from this flow.
    var childCoordinator: BaseCoordinator? {
        didSet {
            childCoordinator?.parentCoordinator = self
        }
    }

    /// The parent flow coordinator that started this flow.
    weak var parentCoordinator: BaseCoordinator?
    
    //MARK: - init
    
    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    //MARK: - Public Methods
    
    func start() {
        assertionFailure("child class must override it.")
    }
}
