//
//  UIStoryboard+Extension.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

extension UIStoryboard {
    enum Name: String {
        case product = "Product"
        case productDetail = "ProductDetail"
    }
    
    convenience init(name: Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }
    
    func initialViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Could not locate view controller in storyboard.")
        }
        
        return viewController
    }
}
