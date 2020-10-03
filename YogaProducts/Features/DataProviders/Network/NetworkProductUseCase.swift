//
//  NetworkProductUseCase.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import Foundation
import Alamofire

final class NetworkProductUseCase: ProductUseCase {
    enum ProductUseCaseError: LocalizedError {
        case productNotFound
        case other(Error)
        
        var errorDescription: String? {
            switch self {
            case .productNotFound:
                return "products are not found. please try again later"
            case .other(let error):
                return error.localizedDescription
            }
        }
    }
    
    private static let productURL = "https://www.yogaeasy.de/api/v1/products?page=0"
    
    func fetchProducts(then completion: @escaping Completion) {
        AF.request(Self.productURL)
            .validate()
            .responseDecodable { (response: DataResponse<ProductResponse, AFError>) in
            
                switch response.result {
                case .failure(let error):
                    completion(.failure(ProductUseCaseError.other(error)))
                case .success(let productResponse) where productResponse.products.isEmpty:
                    completion(.failure(ProductUseCaseError.productNotFound))
                case .success(let productResponse):
                    completion(.success(productResponse.products))
                }
        }
    }
}
