//
//  NewsSourcePresenter.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation

protocol NewsSourcePresenterInput {
    var interactor: NewsSourceInteractorProtocol! { get set }
    var router: NewsSourceRouterProtocol! { get set }
    
    func fetchNewsSource(for categoryName: String)
    func newsSourceTotal() -> Int
    func newsSourceName(at indexPath: IndexPath) -> String
    func discoverNewsArticle(at indexPath: IndexPath)
    func routeToNewsArticle(with newsSourceID: String)
}

protocol NewsSourcePresenterOutput {
    var view: NewsSourceViewProtocol! { get set }
    
    func reloadNewsSource()
    func routeToNewsArticle(with newsSourceID: String)
}

class NewsSourcePresenter: NewsSourcePresenterInput {
    
    var interactor: NewsSourceInteractorProtocol!
    var view: NewsSourceViewProtocol!
    var router: NewsSourceRouterProtocol!
    
    func fetchNewsSource(for categoryName: String) {
        interactor.fetchNewsSource(for: categoryName)
    }
    
    func newsSourceTotal() -> Int {
        interactor.newsSourceTotal()
    }
    
    func newsSourceName(at indexPath: IndexPath) -> String {
        interactor.newsSourceName(at: indexPath)
    }
    
    func discoverNewsArticle(at indexPath: IndexPath) {
        interactor.discoverNewsArticle(at: indexPath)
    }
    
}

extension NewsSourcePresenter: NewsSourcePresenterOutput {
    
    func reloadNewsSource() {
        view.reloadNewsSource()
    }
    
    func routeToNewsArticle(with newsSourceID: String) {
        router.routeToNewsArticle(with: newsSourceID)
    }
    
}
