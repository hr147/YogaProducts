//
//  ProductRowViewModel.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import Foundation

struct ProductRowViewModel {
    let id: Int
    let titleInfo: String
    let description: NSAttributedString?
}

extension ProductRowViewModel: Hashable {
    static func == (lhs: ProductRowViewModel, rhs: ProductRowViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
