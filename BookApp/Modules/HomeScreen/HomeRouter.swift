import Foundation
import UIKit

protocol HomeRouterProtocol {
    func goToDetail(bookId: Int)
    func showError()
}

class HomeRouter: HomeRouterProtocol {
     var viewController: HomeViewController
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func goToDetail(bookId: Int) {
        let controller = DetailAssembly().make(bookId: bookId)
        self.viewController.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Smth goes wrong", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.viewController.present(alert, animated: true)
    }
}
