//
//  ProductFactory.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

final class ProductViewControllersFactory {
    // MARK:- Private Properties
    
    private let productUseCase: ProductUseCase
    
    // MARK:- Init
    
    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    // MARK:- Public Methods
    
    func makeProductViewController() -> ProductViewController {
        let storyboard = UIStoryboard(name: .product)
        let viewModel = ProductViewModel(productUseCase: productUseCase)
        let viewController = storyboard.instantiateInitialViewController {
            ProductViewController(coder: $0, viewModel: viewModel)
        }
        
        guard let productViewController = viewController else {
            fatalError("Failed to load ProductViewController from storyboard.")
        }
        
        return productViewController
    }
}
