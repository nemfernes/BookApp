import UIKit
import SnapKit

protocol HomeViewControllerProtocol: AnyObject {
    func setupData()
    func isLoading(status: Bool)
}

class HomeViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    var timer: Timer?
    
    private lazy var libraryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.pink
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.text = "Library"
        return label
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .lightGray
        return loader
    }()
    
    private lazy var topPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = Color.pink
        pageControl.pageIndicatorTintColor = Color.pageIndicator
        pageControl.numberOfPages = 10
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .automatic
        return pageControl
    }()
    
    private lazy var newLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textWhite
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.text = "New Arrivals"
        return label
    }()
    
    private lazy var romanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textWhite
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.text = "Romance"
        return label
    }()
    
    private lazy var comedyLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textWhite
        label.font = UIFont(name: Font.nunitoSansBold, size: 20)
        label.text = "Top Romantic Comedy"
        return label
    }()
    
    private lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.defaultReuseIdentifier)
        collectionView.tag = 1
        return collectionView
    }()
    
    private lazy var newCollectionView: UICollectionView = {
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
    
    private lazy var romanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.defaultReuseIdentifier)
        collectionView.tag = 3
        return collectionView
    }()
    
    private lazy var comedyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.defaultReuseIdentifier)
        collectionView.tag = 4
        return collectionView
    }()
    
    var presenter: HomePresenterProtocol!
    
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
    
    @objc func autoScroll() {
        if let indexPath = bannersCollectionView.indexPathsForVisibleItems.first {
            var nextItem = indexPath.item + 1
            if nextItem >= presenter.bannerList.count {
                nextItem = 0
            }
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            bannersCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
}

extension HomeViewController: Designable {
    func setupView() {
        self.view.backgroundColor = Color.blackBackground
        self.contentView.backgroundColor = .clear
    }
    
    func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        [
            self.libraryLabel,
            self.bannersCollectionView,
            self.newLabel,
            self.newCollectionView,
            self.romanceLabel,
            self.romanceCollectionView,
            self.comedyLabel,
            self.comedyCollectionView,
            self.topPageControl,
            self.loader
        ].forEach(self.contentView.addSubview)
    }
    
    func makeConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.libraryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(38)
        }
        
        self.bannersCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(libraryLabel.snp.bottom).offset(28)
            make.height.equalTo(bannersCollectionView.snp.width).multipliedBy(0.45)
        }
        
        self.topPageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bannersCollectionView.snp.bottom).inset(12)
            make.height.equalTo(10)
            make.width.equalTo(250)
        }
        
        self.newLabel.snp.makeConstraints { make in
            make.leading.equalTo(libraryLabel)
            make.top.equalTo(bannersCollectionView.snp.bottom).offset(30)
        }
        
        self.newCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(5)
            make.top.equalTo(newLabel.snp.bottom).offset(16)
            make.height.equalTo(newCollectionView.snp.width).multipliedBy(0.55)
        }
        
        self.romanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(libraryLabel)
            make.top.equalTo(newCollectionView.snp.bottom).offset(30)
        }
        
        self.romanceCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(romanceLabel.snp.bottom).offset(16)
            make.height.equalTo(romanceCollectionView.snp.width).multipliedBy(0.55)
        }
        
        self.loader.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        self.comedyLabel.snp.makeConstraints { make in
            make.leading.equalTo(libraryLabel)
            make.top.equalTo(romanceCollectionView.snp.bottom).offset(30)
        }
        
        self.comedyCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(comedyLabel.snp.bottom).offset(16)
            make.height.equalTo(comedyCollectionView.snp.width).multipliedBy(0.55)
            make.bottom.equalToSuperview().inset(45)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return presenter.bannerList.count
        case 2:
            return presenter.getNew().count
        case 3:
            return presenter.getComedy().count
        case 4:
            return presenter.getRomance().count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let banner = presenter.bannerList[indexPath.row]
            cell.configure(banner: banner)
            return cell
        case 2:
            let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let book = presenter.getNew()[indexPath.row]
            cell.configure(book: book)
            return cell
        case 3:
            let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let book = presenter.getRomance()[indexPath.row]
            cell.configure(book: book)
            return cell
        case 4:
            let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let book = presenter.getComedy()[indexPath.row]
            cell.configure(book: book)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            let bookID = presenter.bannerList[indexPath.row].bookID
            if let book = presenter.getBookById(id: bookID) {
                presenter.goToDetail(bookId: bookID)
            }
        case 2:
            let book = presenter.getNew()[indexPath.row]
            presenter.goToDetail(bookId: book.id)
        case 3:
            let book = presenter.getComedy()[indexPath.row]
            presenter.goToDetail(bookId: book.id)
        case 4:
            let book = presenter.getRomance()[indexPath.row]
            presenter.goToDetail(bookId: book.id)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: collectionView.frame.size.width - 32, height: collectionView.frame.size.height)
        default:
            return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 1:
            return 32
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        topPageControl.currentPage = Int(pageIndex)
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func isLoading(status: Bool) {
        DispatchQueue.main.async {
            status ? self.loader.startAnimating() : self.loader.stopAnimating()
        }
    }
    
    func setupData() {
        DispatchQueue.main.async {
            self.topPageControl.numberOfPages = self.presenter.bannerList.count
            self.startAutoScroll()
            self.bannersCollectionView.reloadData()
            self.newCollectionView.reloadData()
            self.romanceCollectionView.reloadData()
            self.comedyCollectionView.reloadData()
        }
    }
}
