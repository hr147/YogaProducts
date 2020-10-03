//
//  ProductViewModel.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import Combine
import Foundation

/// define all states of view.
enum ProductViewModelState {
    case show([ProductRowViewModel])
    case error(String)
}

final class ProductViewModel {
    // MARK:- Public Properties
    
    let screenTitle = "Products"
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK:- Private Properties
    
    private let productUseCase: ProductUseCase
    private let stateDidUpdateSubject = PassthroughSubject<ProductViewModelState, Never>()
    
    // MARK:- Init
    
    init(productUseCase: ProductUseCase = NetworkProductUseCase()) {
        self.productUseCase = productUseCase
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

