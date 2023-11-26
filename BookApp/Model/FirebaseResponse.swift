import Foundation

struct FirebaseResponse: Codable {
    let books: [Book]
    let topBannerSlides: [TopBannerSlide]
    let youWillLikeSection: [Int]
    
    enum CodingKeys: String, CodingKey {
        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }
}

struct Book: Codable {
    let id: Int
    let name, author, summary, genre: String
    let coverURL: String
    let views, likes, quotes: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, author, summary, genre
        case coverURL = "cover_url"
        case views, likes, quotes
    }
}

struct TopBannerSlide: Codable {
    let id, bookID: Int
    let cover: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookID = "book_id"
        case cover
    }
}

struct BookInfo {
    
    let title: String
    let value: String
}

struct BookInfoData {
    
    func getDetailInfo(book: Book)-> [BookInfo] {
        var infoList = [BookInfo]()
        
        infoList.append(BookInfo(title: "Readers", value: book.views))
        infoList.append(BookInfo(title: "Likes", value: book.likes))
        infoList.append(BookInfo(title: "Quotes", value: book.quotes))
        infoList.append(BookInfo(title: "Genre", value: book.genre))
        return infoList
    }
}

