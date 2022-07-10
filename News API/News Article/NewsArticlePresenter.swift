//
//  NewsArticlePresenter.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation

import Foundation

protocol NewsArticlePresenterInput {
    var interactor: NewsArticleInteractorProtocol! { get set }
    var router: NewsArticleRouterProtocol! { get set }
    
    func articleTotal() -> Int
    func articleName(at indexPath: IndexPath) -> String
    func fetchArticle(pagination: Bool, for newsSourceID: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void)
    func addData(data: [NewsArticle])
    func getPaginatingStatus() -> Bool
    func openArticle(at indexPath: IndexPath)
    func searchBarActive(searchText: String, newsSourceID: String, elseRun: @escaping ()->())
    func getSearchBarText() -> String
}

protocol NewsArticlePresenterOutput {
    var view: NewsArticleViewProtocol! { get set }
    func routeToWebView(with url: String)
    func reloadnewsArticle()
}

class NewsArticlePresenter: NewsArticlePresenterInput {
    
    var interactor: NewsArticleInteractorProtocol!
    var view: NewsArticleViewProtocol!
    var router: NewsArticleRouterProtocol!
    
    func articleTotal() -> Int {
        interactor.articleTotal()
    }
    
    func articleName(at indexPath: IndexPath) -> String {
        interactor.articleName(at: indexPath)
    }
    
    func fetchArticle(pagination: Bool, for newsSourceID: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        interactor.fetchArticle(pagination: pagination, for: newsSourceID, completion: completion)
    }
    
    func addData(data: [NewsArticle]) {
        interactor.addData(data: data)
    }
    
    func getPaginatingStatus() -> Bool {
        interactor.getPaginatingStatus()
    }
    
    func openArticle(at indexPath: IndexPath) {
        interactor.openArticle(at: indexPath)
    }
    
    func searchBarActive(searchText: String, newsSourceID: String, elseRun: @escaping ()->()) {
        interactor.searchBarActive(searchText: searchText, newsSourceID: newsSourceID, elseRun: elseRun)
    }
    
    func getSearchBarText() -> String {
        interactor.getSearchBarText()
    }
    
}

extension NewsArticlePresenter: NewsArticlePresenterOutput {
    func routeToWebView(with url: String) {
        router.routeToWebView(with: url)
    }
    
    func reloadnewsArticle() {
        view.reloadnewsArticle()
    }
    
    
}
