import SnapKit
import UIKit

class BannerCollectionViewCell: UICollectionViewCell, Reusable {
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(banner: TopBannerSlide) {
        self.bannerImageView.load(url: banner.cover)
    }
}


extension BannerCollectionViewCell: Designable {
    
    func setupView() {
        
    }
    
    func addSubviews() {
        [
            bannerImageView
        ].forEach(self.contentView.addSubview)
    }
    
    func makeConstraints() {
        self.bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
