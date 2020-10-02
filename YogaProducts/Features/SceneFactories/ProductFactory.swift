//
//  ProductFactory.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

class ProductFactory: NSObject {
    func productViewController() -> ProductViewController {
        let storyboard = UIStoryboard(name: .product)
        let viewController = storyboard.instantiateInitialViewController {
            ProductViewController(coder: $0, viewModel: .init())
        }
        
        guard let productViewController = viewController else {
            fatalError("Failed to load ProductViewController from storyboard.")
        }
        
        return productViewController
    }
}
