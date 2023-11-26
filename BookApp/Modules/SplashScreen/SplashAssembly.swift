import Foundation
import UIKit

final class SplashAssembly {
    func make() -> UIViewController {
        let controller = SplashViewController()
        let router = SplashRouter(viewController: controller)
        let presenter = SplashPresenter(viewController: controller, router: router)
        controller.presenter = presenter
        return UINavigationController(rootViewController:controller)
    }
}
