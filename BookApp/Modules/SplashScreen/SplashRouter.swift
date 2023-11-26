import Foundation

protocol SplashRouterProtocol {
   func goToHome()
}

class SplashRouter: SplashRouterProtocol {
     var viewController: SplashViewController
    
    init(viewController: SplashViewController) {
        self.viewController = viewController
    }
    
    func goToHome() {
        let controller = HomeAssembly().make()
    self.viewController.navigationController?.pushViewController(controller, animated: true)
    }
}
