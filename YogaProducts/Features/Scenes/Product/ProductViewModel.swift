//
//  ProductViewModel.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import Combine
import Foundation
import CoreGraphics

/// define all states of view.
enum ProductViewModelState {
    case show([ProductRowViewModel])
    case error(String)
}

protocol ProductNavigator: class {
    func showProductDetail()
}

final class ProductViewModel {
    // MARK:- Public Properties
    
    let screenTitle = "Products"
    let topSpacingForPortrait: CGFloat = 32.0
    let topSpacingForLandscape: CGFloat = 16.0
    
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK:- Private Properties
    
    private let productUseCase: ProductUseCase
    private let stateDidUpdateSubject = PassthroughSubject<ProductViewModelState, Never>()
    private unowned let navigator: ProductNavigator
    
    // MARK:- Init
    
    init(productUseCase: ProductUseCase, navigator: ProductNavigator) {
        self.productUseCase = productUseCase
        self.navigator = navigator
    }
    
    // MARK:- Public Methods
    
    func viewDidLoad() {
        productUseCase.fetchProducts {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.stateDidUpdateSubject.send(.error(error.localizedDescription))
            case .success(let products):
                let productRows = products.map(self.makeProductRowViewModel(with:))
                self.stateDidUpdateSubject.send(.show(productRows))
            }
        }
    }
    
    func cellDidSelect() {
        navigator.showProductDetail()
    }
    
    // MARK:- Private methods
    
    private func makeProductRowViewModel(with product: Product) -> ProductRowViewModel {
        .init(id: product.id,
              titleInfo: product.name + " | " + "\(product.cost)",
              description: makeAttributedString(withHTMLText: product.description))
    }
    
    private func makeAttributedString(withHTMLText text: String) -> NSAttributedString? {
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

