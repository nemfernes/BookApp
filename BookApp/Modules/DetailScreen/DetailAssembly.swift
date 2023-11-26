import Foundation
import UIKit

final class DetailAssembly {
    func make(bookId: Int) -> UIViewController {
        let controller = DetailViewController()
        let router = DetailRouter(viewController: controller)
        let presenter = DetailPresenter(viewController: controller, router: router, bookId: bookId)
        controller.presenter = presenter
        return controller
    }
}
