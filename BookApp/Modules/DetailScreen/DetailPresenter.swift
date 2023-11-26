import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func goBack()
    var bookList: [Book] {get}
    var recList: [Book] {get}
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var viewController: DetailViewControllerProtocol?
    var router: DetailRouterProtocol
    
    let bookId: Int
    var bookList = [Book]() {
        didSet {
            guard let index = self.bookList.firstIndex(where: { $0.id == bookId }) else {
                return
            }
            self.viewController?.setupData(scrollTo: index)
        }
    }
    var recList =  [Book]()
    
    init(viewController: DetailViewController, router: DetailRouter, bookId: Int) {
        self.viewController = viewController
        self.router = router
        self.bookId = bookId
    }
    
    func viewDidLoad() {
        self.getData()
    }
    
    func goBack() {
        router.goBack()
    }
    
   private func getData() {
        viewController?.isLoading(status: true)
        FirebaseManager.instance.fetchHome { [weak self] response in
            guard let self = self else {return}
            if let response = response {
                self.recList = self.getRecBooks(books: response)
                self.bookList = response.books
                self.viewController?.isLoading(status: false)
            } else {
                self.viewController?.isLoading(status: false)
                self.router.showError()
            }
        }
    }
    
    private func getRecBooks(books: FirebaseResponse)-> [Book] {
        let filteredArray = books.books.filter { object in
            books.youWillLikeSection.contains(object.id)
        }
        return filteredArray
    }
}
