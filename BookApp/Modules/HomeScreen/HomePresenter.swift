import Foundation

protocol HomePresenterProtocol {
    func goToDetail(bookId: Int)
    func viewDidLoad()
    func getNew()-> [Book]
    func getRomance()-> [Book]
    func getComedy()-> [Book]
    func getBookById(id: Int)-> Book?
    var bannerList: [TopBannerSlide] {get}
}

class HomePresenter: HomePresenterProtocol {
    
    weak var viewController: HomeViewControllerProtocol?
    var router: HomeRouterProtocol
    
    var bookList = [Book]()
    var bannerList = [TopBannerSlide]()
    
    init(viewController: HomeViewController, router: HomeRouter) {
        self.viewController = viewController
        self.router = router
    }
    
    func viewDidLoad() {
        self.getData()
    }
    
    func goToDetail(bookId: Int) {
        router.goToDetail(bookId: bookId)
    }
    
    func getData() {
        viewController?.isLoading(status: true)
        FirebaseManager.instance.fetchHome { [weak self] response in
            if let response = response {
                self?.bookList = response.books
                self?.bannerList = response.topBannerSlides
                self?.viewController?.setupData()
                self?.viewController?.isLoading(status: false)
            } else {
                self?.viewController?.isLoading(status: false)
                self?.router.showError()
            }
        }
    }
    
    func getNew()-> [Book] {
        self.bookList.filter({ $0.genre == "Fantasy"
        })
    }
    
    func getRomance()-> [Book] {
        self.bookList.filter({ $0.genre == "Romance"
        })
    }
    
    func getComedy()-> [Book] {
        self.bookList.filter({ $0.genre == "Science"
        })
    }
    
    func getBookById(id: Int)-> Book? {
        bookList.filter({ $0.id == id }).first
    }
}
