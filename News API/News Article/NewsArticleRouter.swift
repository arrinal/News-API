//
//  NewsArticleRouter.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation
import UIKit

protocol NewsArticleRouterProtocol {
    static func start(with newsSourceID: String) -> UIViewController
    func routeToWebView(with url: String)
}

class NewsArticleRouter: NewsArticleRouterProtocol {
    
    var entry: UIViewController?
    
    static func start(with newsSourceID: String) -> UIViewController {
        let router = NewsArticleRouter()
        
        let view = NewsArticleView()
        let presenter = NewsArticlePresenter()
        let interactor = NewsArticleInteractor()
        
        view.newsSourceID = newsSourceID
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view
        
        return view
    }
    
    func routeToWebView(with url: String) {
        entry?.navigationController?.pushViewController(ArticleWebView(url: url), animated: true)
    }
}
