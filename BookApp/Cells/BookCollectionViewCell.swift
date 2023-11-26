import SnapKit
import UIKit

class BookCollectionViewCell: UICollectionViewCell, Reusable {
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textGray
        label.numberOfLines = 2
        label.font = UIFont(name: Font.nunitoSansSemiBold, size: 16)
        return label
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
    
    func configure(book: Book) {
        self.nameLabel.text = book.name
        self.bookImageView.load(url: book.coverURL)
    }
}


extension BookCollectionViewCell: Designable {
    
    func setupView() {
    }
    
    func addSubviews() {
        [
            bookImageView,
            nameLabel
        ].forEach(self.contentView.addSubview)
    }
    
    func makeConstraints() {
        self.nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bookImageView.snp.bottom).offset(5)
        }
        
        self.bookImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(1.25)
        }
    }
}
