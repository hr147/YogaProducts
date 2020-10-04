//
//  ProductCoordinator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import UIKit

final class ProductCoordinator: BaseCoordinator<AppNavigationController> {
    override func start() {
        let factory = ServiceLocator.productViewControllersFactory()
        let productViewController = factory.makeProductViewController(navigator: self)
        rootViewController.pushViewController(productViewController, animated: true)
    }
}

extension ProductCoordinator: ProductNavigator {
    func showProductDetail() {
        let factory = ServiceLocator.productViewControllersFactory()
        let productDetailViewController = factory.makeProductDetailViewController()
        rootViewController.pushViewController(productDetailViewController, animated: true)
    }
}
