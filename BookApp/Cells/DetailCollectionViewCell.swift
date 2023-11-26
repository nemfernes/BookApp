import CollectionViewPagingLayout
import UIKit

class DetailCollectionViewCell: UICollectionViewCell, ScaleTransformView, Reusable {
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansBold, size: 12)
        label.textColor = Color.splashGray
        return label
    }()
    
    private var backView = UIView()
    private lazy var zodiacImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var scaleOptions = ScaleTransformViewOptions(
            minScale: 0.50,
            maxScale: 2.00,
            scaleRatio: 0.36,
            translationRatio: .init(x: 0.95, y: 1.48),
            minTranslationRatio: .init(x: -5.00, y: -5.00),
            maxTranslationRatio: .init(x: 5.00, y: 0.02),
            keepVerticalSpacingEqual: false,
            keepHorizontalSpacingEqual: false,
            scaleCurve: .linear,
            translationCurve: .linear,
            shadowEnabled: true,
            shadowColor: .black,
            shadowOpacity: 0.60,
            shadowRadiusMin: 2.00,
            shadowRadiusMax: 13.00,
            shadowOffsetMin: .init(width: 0.00, height: 2.00),
            shadowOffsetMax: .init(width: 0.00, height: 7.00),
            shadowOpacityMin: 0.00,
            shadowOpacityMax: 0.10,
            blurEffectEnabled: false,
            blurEffectRadiusRatio: 0.27,
            blurEffectStyle: .light,
            rotation3d: nil,
            translation3d: nil
        )

    
    var card: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: Book) {
        zodiacImageView.load(url: item.coverURL)
        authorLabel.text = item.author
        nameLabel.text = item.name
    }
}


extension DetailCollectionViewCell: Designable {
    
    func setupView() {
       // self.backView.backgroundColor = .darkGray
    }
    
    func addSubviews() {
        [
            self.authorLabel,
            self.nameLabel,
            self.zodiacImageView
        ].forEach(self.backView.addSubview)
        [
            backView
        ].forEach(contentView.addSubview)
    }
    
    func makeConstraints() {
        self.backView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(320)
        }
        self.zodiacImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(backView)
            make.height.equalTo(self.zodiacImageView.snp.width).multipliedBy(1.25)
        }

        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.authorLabel.snp.bottom)
            make.centerX.equalTo(backView)
        }

        self.authorLabel.snp.makeConstraints { make in
            make.top.equalTo(self.zodiacImageView.snp.bottom).offset(15)
            make.centerX.equalTo(backView)
         
        }
    }
}

