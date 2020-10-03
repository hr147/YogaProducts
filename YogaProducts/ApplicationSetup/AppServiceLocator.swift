//
//  AppServiceLocator.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import UIKit
import Swinject

let ServiceLocator = AppServiceLocator.shared

///`AppServiceLocator` is responsible to create/manage all dependencies of the application.
final class AppServiceLocator {
    // MARK:- Class Property
    
    static let shared = AppServiceLocator()
    
    // MARK:- Private Properties
    
    private let container = Container()
    
    // MARK:- Init
    
    private init(){
        //Register dependencies
        
        container.register(ProductUseCase.self) { _  in NetworkProductUseCase() }.inObjectScope(.container)
        container.register(ProductViewControllersFactory.self) { resolver  in
            guard let productUseCase = resolver.resolve(ProductUseCase.self) else {
                fatalError("ProductViewControllersFactory dependencies are missings.")
            }
            
            return ProductViewControllersFactory(productUseCase: productUseCase)
        }.inObjectScope(.container)
        
    }
    
    // MARK: - Public Methods: Resolve Dependencies
    
    func productUseCase() -> ProductUseCase {
        container.resolve(ProductUseCase.self)!
    }
    
    func productViewControllersFactory() -> ProductViewControllersFactory {
        container.resolve(ProductViewControllersFactory.self)!
    }
}
