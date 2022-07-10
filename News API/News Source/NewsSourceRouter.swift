//
//  NewsSourceRouter.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation
import UIKit

protocol NewsSourceRouterProtocol {
    static func start(categoryName: String) -> UIViewController
    func routeToNewsArticle(with newsSourceID: String)
}

class NewsSourceRouter: NewsSourceRouterProtocol {
    
    var entry: UIViewController?
    
    static func start(categoryName: String) -> UIViewController {
        let router = NewsSourceRouter()
        
        let view = NewsSourceView()
        let presenter = NewsSourcePresenter()
        let interactor = NewsSourceInteractor()
        
        view.categoryName = categoryName
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return view
    }
    
    func routeToNewsArticle(with newsSourceID: String) {
        let newsArticleView = NewsArticleRouter.start(with: newsSourceID)
        entry?.navigationController?.pushViewController(newsArticleView, animated: true)
    }
}
