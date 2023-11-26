import UIKit
import CollectionViewPagingLayout
import SnapKit

protocol DetailViewControllerProtocol: AnyObject {
    func setupData(scrollTo: Int)
    func isLoading(status: Bool)
}

class DetailViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 16
        view.backgroundColor =  .white
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.gray
        return view
    }()
    
    private lazy var dividerSummaryView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.gray
        return view
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blackBackground
        return view
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.text = "Summary"
        label.textColor = Color.textBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansSemiBold, size: 14)
        label.numberOfLines = 0
        label.textColor = Color.textBlack
        return label
    }()
    
    private lazy var recomendationLabel: UILabel = {
        let label = UILabel()
        label.text = "You will also like"
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.textColor = Color.textBlack
        return label
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansSemiBold, size: 12)
        label.textColor = Color.textGray
        label.textAlignment = .center
        return label
    }()
    
    let layout = CollectionViewPagingLayout()
    
    private lazy var carouselCollectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.defaultReuseIdentifier)
        collectionView.tag = 1
        return collectionView
    }()
    
    private lazy var recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.defaultReuseIdentifier)
        collectionView.tag = 2
        return collectionView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .lightGray
        return loader
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detail_background")?.withAlpha(0.35)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = Color.purpleBackground
        imageView.alpha = 0.35
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var readButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read now", for: .normal)
        button.setTitleColor(Color.textWhite, for: .normal)
        button.titleLabel?.font =  UIFont(name: Font.nunitoSansExtraBold, size: 16.0)
        button.backgroundColor = Color.buttonBackground
        button.layer.cornerRadius = 20
        return button
    }()
    
    var presenter: DetailPresenterProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
        self.presenter.viewDidLoad()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backPressed() {
        presenter.goBack()
    }
    
    func update(book: Book) {
        hStack.removeFullyAllArrangedSubviews()
        BookInfoData().getDetailInfo(book: book).forEach { info in
            let view = BookInfoView()
            view.setup(header: info.value, title: info.title)
            hStack.addArrangedSubview(view)
        }
    }
}

extension DetailViewController: Designable {
    func setupView() {
        self.view.backgroundColor = .white
    }
    
    func addSubviews() {
        [
            topView,
            backgroundImageView,
            scrollView,
            backButton,
            loader
        ].forEach(self.view.addSubview)
        self.scrollView.addSubview(self.contentView)
        [
            carouselCollectionView,
            containerView,
        ].forEach(self.contentView.addSubview)
        [
            hStack,
            dividerView,
            summaryLabel,
            descriptionLabel,
            dividerSummaryView,
            recomendationLabel,
            recCollectionView,
            readButton
        ].forEach(self.containerView.addSubview)
    }
    
    func makeConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.height.equalTo(25)
        }
        
        self.backgroundImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        self.topView.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundImageView)
        }
        
        self.carouselCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(50)
            make.height.equalTo(320)
        }
        
        self.containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(backgroundImageView)
            make.top.equalTo(carouselCollectionView.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
        self.hStack.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView).inset(35)
            make.top.equalTo(containerView).offset(20)
        }
        
        self.dividerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(1)
            make.top.equalTo(hStack.snp.bottom).offset(50)
        }
        
        self.summaryLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView).inset(16)
            make.top.equalTo(dividerView).offset(16)
        }
        
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView).inset(16)
            make.top.equalTo(summaryLabel.snp.bottom).offset(8)
        }
        
        self.dividerSummaryView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(1)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        self.recomendationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(summaryLabel)
            make.top.equalTo(dividerSummaryView.snp.bottom).offset(16)
        }
        
        self.recCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(recomendationLabel.snp.bottom).offset(16)
            make.height.equalTo(recCollectionView.snp.width).multipliedBy(0.55)
        }
        
        self.readButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.top.equalTo(recCollectionView.snp.bottom).offset(25)
            make.height.equalTo(50)
            make.width.equalTo(280)
            make.bottom.equalTo(containerView).inset(20)
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewPagingLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return presenter.bookList.count
        case 2:
            return presenter.recList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell: DetailCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let book = presenter.bookList[indexPath.row]
            cell.setup(item: book)
            return cell
        case 2:
            let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let book = presenter.recList[indexPath.row]
            cell.configure(book: book)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        let book = presenter.bookList[currentPage]
        self.update(book: book)
        self.descriptionLabel.text = book.summary
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func isLoading(status: Bool) {
        DispatchQueue.main.async {
            status ? self.loader.startAnimating() : self.loader.stopAnimating()
        }
    }
    
    func setupData(scrollTo: Int) {
        DispatchQueue.main.async {
            self.carouselCollectionView.reloadData()
            let currentOffset = self.carouselCollectionView.contentOffset
            let desiredOffset = CGPoint(x: 1, y: currentOffset.y)
            UIView.animate(withDuration: 0.1) {
                self.carouselCollectionView.setContentOffset(desiredOffset, animated: true)
                if scrollTo != 0 {
                    self.layout.setCurrentPage(scrollTo)
                }
            }
            guard let book = self.presenter.bookList.first else {return}
            self.update(book: book)
            self.descriptionLabel.text = book.summary
        }
    }
    
}
