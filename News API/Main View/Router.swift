//
//  Router.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController

protocol NewsRouterProtocol {
    
    var entry: EntryPoint? { get }
    
    static func start() -> NewsRouterProtocol
    func routeToNewsSource(with categoryName: String)
}


class NewsRouter: NewsRouterProtocol {
    
    
    var entry: EntryPoint?
    
    static func start() -> NewsRouterProtocol {
        let router = NewsRouter()
        
        let view = ViewController()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        
        router.entry = view as EntryPoint
        
        
        
        return router
    }
    
    func routeToNewsSource(with categoryName: String) {
        let newsSourceView = NewsSourceRouter.start(categoryName: categoryName)
        entry?.navigationController?.pushViewController(newsSourceView, animated: true)
    }
}
