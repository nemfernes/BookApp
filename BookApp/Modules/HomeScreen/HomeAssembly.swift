import Foundation
import UIKit

final class HomeAssembly {
    func make() -> UIViewController {
        let controller = HomeViewController()
        let router = HomeRouter(viewController: controller)
        let presenter = HomePresenter(viewController: controller, router: router)
        controller.presenter = presenter
        return controller
    }
}
