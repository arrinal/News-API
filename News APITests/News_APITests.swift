//
//  News_APITests.swift
//  News APITests
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import XCTest
@testable import News_API

class News_APITests: XCTestCase {

    var presenter: NewsPresenterInput & NewsPresenterOutput = NewsPresenter()
    var interactor: NewsInteractorProtocol! = NewsInteractor()
    var router: NewsRouterProtocol! = NewsRouter()
    
    var presenterNewsSource: NewsSourcePresenterInput & NewsSourcePresenterOutput = NewsSourcePresenter()
    var interactorNewsSource: NewsSourceInteractorProtocol! = NewsSourceInteractor()
    var routerNewsSource: NewsSourceRouterProtocol! = NewsSourceRouter()
    
    var presenteNewsArticle: NewsArticlePresenterInput & NewsArticlePresenterOutput = NewsArticlePresenter()
    var interactorNewsArticle: NewsArticleInteractorProtocol! = NewsArticleInteractor()
    var routerNewsArticle: NewsArticleRouterProtocol! = NewsArticleRouter()
    var viewNewsArticle: NewsArticleViewProtocol! = NewsArticleView()
    
    override func setUp() {
        super.setUp()
        
        self.interactor.presenter = presenter
        self.presenter.router = router
        self.presenter.interactor = interactor
        
        self.interactorNewsSource.presenter = presenterNewsSource
        self.presenterNewsSource.router = routerNewsSource
        self.presenterNewsSource.interactor = interactorNewsSource
        
        self.interactorNewsArticle.presenter = presenteNewsArticle
        self.presenteNewsArticle.router = routerNewsArticle
        self.presenteNewsArticle.interactor = interactorNewsArticle
        self.presenteNewsArticle.view = viewNewsArticle
        
    }
    
    func test() {
        
        XCTAssertEqual(presenter.categoryTotal(), 7)
        XCTAssertEqual(presenter.categoryName(at: IndexPath(row: 0, section: 0)), "Business")
    }
    
    func test_news_source() {

        interactorNewsSource.newsSource = [NewsSource(id: "bloomberg", name: "Bloomberg", url: "https://bloomberg.com", category: "Business"), NewsSource(id: "bi", name: "Business Insider", url: "https://business-insider.com", category: "Business")]
        XCTAssertEqual(presenterNewsSource.newsSourceTotal(), 2)
        XCTAssertEqual(presenterNewsSource.newsSourceName(at: IndexPath(row: 1, section: 0)), "Business Insider")

    }

    func test_news_article() {

        interactorNewsArticle.newsArticle = [NewsArticle(id: "bloomberg", title: "Elon Musk Cancel to Buy Twitter", url: "https://bloomberg.com", publishedAt: "2022-09-07"), NewsArticle(id: "times", title: "Lorem Ipsum Dolor", url: "https://times.com", publishedAt: "2022-09-07")]
        XCTAssertEqual(presenteNewsArticle.articleTotal(), 2)
        XCTAssertNotNil(presenteNewsArticle.articleTotal())
        presenteNewsArticle.addData(data: [NewsArticle(id: "entertainment", title: "Test 123", url: "https://youtube.com", publishedAt: "2022-09-10")])
        XCTAssertNotEqual(presenteNewsArticle.articleTotal(), 2)
        XCTAssertEqual(presenteNewsArticle.articleTotal(), 3)

    }

}
