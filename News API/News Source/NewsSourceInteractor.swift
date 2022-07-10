//
//  NewsSourceInteractor.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation
import SwiftyJSON

protocol NewsSourceInteractorProtocol {
    var presenter: NewsSourcePresenterOutput! { get set }
    var newsSource: [NewsSource] { get set }
    
    func fetchNewsSource(for categoryName: String)
    func newsSourceTotal() -> Int
    func newsSourceName(at indexPath: IndexPath) -> String
    func discoverNewsArticle(at indexPath: IndexPath)
}

class NewsSourceInteractor: NewsSourceInteractorProtocol {
    
    var presenter: NewsSourcePresenterOutput!
    var newsSource = [NewsSource]()
    
    func fetchNewsSource(for categoryName: String) {
        let source = "https://newsapi.org/v2/top-headlines/sources?category=\(categoryName)&apiKey=4a17051ecc0d43819c8d157215e9a9db"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
                
            }
            
            if let newsAPI = try? JSON(data: data!) {
                
                let sources = newsAPI["sources"]
                
                
                for source in sources {
                    let id = source.1["id"].stringValue
                    let name = source.1["name"].stringValue
                    let url = source.1["url"].stringValue
                    let category = source.1["url"].stringValue
                    
                    DispatchQueue.main.async {
                        self.newsSource += [NewsSource(id: id, name: name, url: url, category: category)]
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.presenter.reloadNewsSource()
            }
            
        }.resume()
        
    }
    
    func newsSourceTotal() -> Int {
        newsSource.count
    }
    
    func newsSourceName(at indexPath: IndexPath) -> String {
        newsSource[indexPath.row].name
    }
    
    func discoverNewsArticle(at indexPath: IndexPath) {
        let newsSourceID = newsSource[indexPath.row].id
        presenter.routeToNewsArticle(with: newsSourceID)
    }
}
