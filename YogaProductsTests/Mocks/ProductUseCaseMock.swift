//
//  ProductUseCaseMock.swift
//  YogaProductsTests
//
//  Created by Haroon Ur Rasheed on 05/10/2020.
//

@testable import YogaProducts

final class ProductUseCaseMock: ProductUseCase {
    struct MockError: Error {}
    
    var fetchProductsResult: Result<[Product], Error> = .failure(MockError())
    
    func fetchProducts(then completion: @escaping Completion) {
            completion(fetchProductsResult)
    }
}
