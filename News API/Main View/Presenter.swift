//
//  Presenter.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation

protocol NewsPresenterInput {
    var interactor: NewsInteractorProtocol!  { get set }
    var router: NewsRouterProtocol!  { get set }
    
    func categoryTotal() -> Int
    func categoryName(at indexPath: IndexPath) -> String
    func discoverNewsSource(at indexPath: IndexPath)
}

protocol NewsPresenterOutput {
    func routeToNewsSource(with categoryName: String)
}

class NewsPresenter: NewsPresenterInput {
    
    
    var interactor: NewsInteractorProtocol!
    var router: NewsRouterProtocol!
    
    func categoryTotal() -> Int {
        interactor.categoryTotal()
    }
    
    func categoryName(at indexPath: IndexPath) -> String {
        interactor.categoryName(at: indexPath)
    }
    
    func discoverNewsSource(at indexPath: IndexPath) {
        interactor.discoverNewsSource(at: indexPath)
    }
}

extension NewsPresenter: NewsPresenterOutput {
    
    func routeToNewsSource(with categoryName: String) {
        router.routeToNewsSource(with: categoryName)
    }
}
