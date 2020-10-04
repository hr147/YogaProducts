//
//  ProductViewController.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 02/10/2020.
//

import UIKit
import Combine

final class ProductViewController: UITableViewController {
    // MARK:- Private Properties
    
    private var cancellable: [AnyCancellable] = []
    private lazy var dataSource = makeDataSource()
    private let viewModel: ProductViewModel
    
    // MARK:- Init
    
    init?(coder: NSCoder, viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    deinit {
        print(String(describing: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    // MARK:- Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellDidSelect()
    }
    
    // MARK:- Private Methods
    
    private func configureUI() {
        title = viewModel.screenTitle
        tableView.dataSource = dataSource
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [unowned self] state in
            self.render(state)
        }).store(in: &cancellable)
    }
    
    private func render(_ state: ProductViewModelState) {
        switch state {
        case .error(let errorMessage):
            update(with: [], animate: true)
            presentAlert(errorMessage)
        case .show(let products):
            update(with: products, animate: true)
        }
    }
}

fileprivate extension ProductViewController {
    enum Section: CaseIterable {
        case products
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, ProductRowViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, productRowViewModel in
                let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: productRowViewModel)
                return cell
            })
    }
    
    private func update(with products: [ProductRowViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, ProductRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(products, toSection: .products)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
