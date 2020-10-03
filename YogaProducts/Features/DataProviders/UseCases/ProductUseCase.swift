//
//  ProductUseCase.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import Foundation

protocol ProductUseCase {
    typealias Completion = (Result<[Product], Error>) -> Void
    
    /// it will fetch products.
    /// - Parameter completion: block triggered when fetching is completed.
    func fetchProducts(then completion: @escaping Completion)
}
