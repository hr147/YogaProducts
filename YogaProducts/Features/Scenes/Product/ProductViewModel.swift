//
//  ProductViewModel.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

final class ProductViewModel {
    let productUseCase: ProductUseCase = NetworkProductUseCase()
    
    init() {
        productUseCase.fetchProducts { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let products):
                print(products)
            }
        }
    }
}
