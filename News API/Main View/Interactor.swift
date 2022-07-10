//
//  Interactor.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation

protocol NewsInteractorProtocol {
    var presenter: NewsPresenterOutput! { get set }
    var category: [Category]  { get set }
    
    func categoryTotal() -> Int
    func categoryName(at indexPath: IndexPath) -> String
    func discoverNewsSource(at indexPath: IndexPath)
}

class NewsInteractor: NewsInteractorProtocol {
    
    var presenter: NewsPresenterOutput!
    var category = [Category(name: "Business"), Category(name: "Entertainment"), Category(name: "General"), Category(name: "Health"), Category(name: "Sciences"), Category(name: "Sports"), Category(name: "Technology")]
    
    func categoryTotal() -> Int {
        category.count
    }
    
    func categoryName(at indexPath: IndexPath) -> String {
        category[indexPath.row].name
    }
    
    func discoverNewsSource(at indexPath: IndexPath) {
        let categoryName = category[indexPath.row].name.lowercased()
        
        presenter.routeToNewsSource(with: categoryName)
    }
    
}
