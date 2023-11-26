import Foundation
import UIKit

protocol DetailRouterProtocol {
    func goBack()
   func showError()
}

class DetailRouter: DetailRouterProtocol {
     var viewController: DetailViewController
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
    func goBack() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Smth goes wrong", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.viewController.present(alert, animated: true)
    }
}
