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
    
    private let notificationCenter = NotificationCenter.default
    private let mainQueue = OperationQueue.main
    private var token: NSObjectProtocol?
    private var cancellable: [AnyCancellable] = []
    private lazy var dataSource = makeDataSource()
    private let viewModel: ProductViewModel
    
    // MARK:- Init
    
    init?(coder: NSCoder, viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    deinit {
        token.map(notificationCenter.removeObserver(_:))
    }
    
    // MARK:- Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override var traitCollection: UITraitCollection {
        var newTraitCollection: [UITraitCollection] = [super.traitCollection]
        if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape {
            newTraitCollection += [UITraitCollection(verticalSizeClass: .compact), UITraitCollection(horizontalSizeClass: .unspecified)]
            
        }
        return UITraitCollection(traitsFrom: newTraitCollection)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellDidSelect()
    }
    
    // MARK:- Private Methods
    
    private func configureUI() {
        registerNotification()
        updateTableViewTopSpacing()
        title = viewModel.screenTitle
        tableView.dataSource = dataSource
    }
    
    private func registerNotification() {
        token = notificationCenter.addObserver(forName: UIDevice.orientationDidChangeNotification,
                                   object: nil,
                                   queue: mainQueue) { [weak self] _ in
            self?.updateTableViewTopSpacing()
        }
    }
    
    private func updateTableViewTopSpacing() {
        guard UIDevice.current.orientation.isLandscape else {
            tableView.contentInset.top = viewModel.topSpacingForPortrait
            return
        }
        
        tableView.contentInset.top = viewModel.topSpacingForLandscape
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
