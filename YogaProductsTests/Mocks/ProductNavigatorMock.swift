//
//  ProductNavigatorMock.swift
//  YogaProductsTests
//
//  Created by Haroon Ur Rasheed on 05/10/2020.
//

@testable import YogaProducts

final class ProductNavigatorMock: ProductNavigator {
    private(set) var showProductDetailDidCall = false
    
    func showProductDetail() {
        showProductDetailDidCall = true
    }
}
