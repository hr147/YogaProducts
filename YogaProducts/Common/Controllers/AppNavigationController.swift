import UIKit

extension UIBarButtonItem {
    static func defaultBackBarButton() -> UIBarButtonItem {
        .init(title: "", style: .plain, target: nil, action: nil)
    }
}

final class AppNavigationController: UINavigationController {
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        viewControllers.first?.navigationItem.backBarButtonItem = .defaultBackBarButton()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.navigationItem.backBarButtonItem = .defaultBackBarButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        navigationBar.barTintColor = .init(color: .standard(.themeColor))
        navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(.avenirDemiBold, size: .standard(.h1))]
        navigationBar.backgroundColor = .init(color: .standard(.themeColor))
    }
}
