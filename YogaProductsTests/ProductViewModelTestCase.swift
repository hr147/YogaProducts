//
//  ProductViewModelTestCase.swift
//  YogaProductsTests
//
//  Created by Haroon Ur Rasheed on 05/10/2020.
//

import XCTest
import Combine
@testable import YogaProducts

final class ProductViewModelTestCase: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testViewModel_shouldHaveValidConfigurations() throws {
        // Given
        let viewModel = makeProductViewModel()
        let expectedTitle = "Products"
        let expectedTopSpacingForLandscape: CGFloat = 16.0
        let expectedTopSpacingForPortrait: CGFloat = 32.0
        
        // Then
        XCTAssertEqual(expectedTitle, viewModel.screenTitle)
        XCTAssertEqual(expectedTopSpacingForLandscape, viewModel.topSpacingForLandscape)
        XCTAssertEqual(expectedTopSpacingForPortrait, viewModel.topSpacingForPortrait)
    }
    
    func testCellDidSelect_shouldNavigateToDetailScreen() throws {
        // Given
        let navigator = ProductNavigatorMock()
        let viewModel = makeProductViewModel(navigator: navigator)
        
        // When
        viewModel.cellDidSelect()
        
        // Then
        XCTAssertTrue(navigator.showProductDetailDidCall)
    }
    
    func testViewDidLoad_whenFetchingFailed_shouldHaveErrorState() throws {
        // Given
        let viewModel = makeProductViewModel()
        var isErrorStateTriggered = false
        
        viewModel.stateDidUpdate.sink { state in
            guard case .error = state else { return }
            
            isErrorStateTriggered =  true
        }.store(in: &cancellables)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(isErrorStateTriggered)
    }
    
    func testViewDidLoad_whenFetchingSuccessful_shouldHaveShowState() throws {
        // Given
        let useCase = ProductUseCaseMock()
        let viewModel = makeProductViewModel(productUseCase: useCase)
        let product = makeProduct()
        useCase.fetchProductsResult = .success([product])
        var isShowStateTriggered = false
        
        viewModel.stateDidUpdate.sink { state in
            guard case .show = state else { return }
            
            isShowStateTriggered =  true
        }.store(in: &cancellables)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(isShowStateTriggered)
    }
}

extension ProductViewModelTestCase {
    func makeProductViewModel(productUseCase: ProductUseCase = ProductUseCaseMock(),
                              navigator: ProductNavigator = ProductNavigatorMock()) -> ProductViewModel {
        .init(productUseCase: productUseCase,
              navigator: navigator)
    }
    
    func makeProduct(id: Int = 1,
                     name: String = "month 1",
                     description: String = "<h1>Hello, world!</h1>",
                     cost: Int = 10000) -> Product {
        .init(id: id, name: name, description: description, cost: cost)
    }
}
