import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func load(url: String) {
        let link = URL(string: url)
        self.kf.setImage(with: link, placeholder: UIImage(named: "placeholder_poster"), options: [.transition(.fade(0.2))])
    }

    func setImageWithIndicator(url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}

