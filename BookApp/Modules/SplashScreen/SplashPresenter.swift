import Foundation

protocol SplashPresenterProtocol {
    func goToHome()
    func viewDidLoad()
}

class SplashPresenter: SplashPresenterProtocol {
    
    weak var viewController: SplashViewControllerProtocol?
    var router: SplashRouterProtocol
    
    init(viewController: SplashViewController, router: SplashRouter) {
        self.viewController = viewController
        self.router = router
    }
    
    func viewDidLoad() {
        viewController?.simulate()
    }
    
    func goToHome() {
        router.goToHome()
    }
}
