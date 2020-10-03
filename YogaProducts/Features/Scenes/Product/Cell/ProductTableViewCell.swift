//
//  ProductTableViewCell.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    //MARK:- private properties
    
    @IBOutlet private weak var productInfoLabel: UILabel!
    @IBOutlet private weak var productDescription: UILabel!
    
    //MARK:- public methods
    
    func configure(with viewModel: ProductRowViewModel) {
        productInfoLabel.text = viewModel.titleInfo
        productDescription.attributedText = viewModel.description
    }
}
