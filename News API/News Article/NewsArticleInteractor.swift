//
//  NewsArticleInteractor.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import Foundation
import SwiftyJSON

protocol NewsArticleInteractorProtocol {
    var presenter: NewsArticlePresenterOutput! { get set }
    var newsArticle: [NewsArticle] { get set }
    
    func articleTotal() -> Int
    func articleName(at indexPath: IndexPath) -> String
    func fetchArticle(pagination: Bool, for newsSourceID: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void)
    func addData(data: [NewsArticle])
    func getPaginatingStatus() -> Bool
    func openArticle(at indexPath: IndexPath)
    func searchBarActive(searchText: String, newsSourceID: String, elseRun: @escaping ()->())
    func getSearchBarText() -> String
}

class NewsArticleInteractor: NewsArticleInteractorProtocol {
    
    var presenter: NewsArticlePresenterOutput!
    var newsArticle = [NewsArticle]()
    var searchBarText = ""
    
    var isPaginating = false
    var currentPage = 1
    
    func fetchArticle(pagination: Bool, for newsSourceID: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        
        
        if pagination {
            isPaginating = true
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: { [self] in
            
            if isPaginating == false {
                let source = "https://newsapi.org/v2/everything?sources=\(newsSourceID)&apiKey=4a17051ecc0d43819c8d157215e9a9db"
                let url = URL(string: source)!
                let session = URLSession(configuration: .default)
        
                session.dataTask(with: url) { data, _, error in
        
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
        
                    }

                    if let newsAPI = try? JSON(data: data!) {
                        
                        let articles = newsAPI["articles"]
        
                        for article in articles {
                            let id = article.1["source"]["id"].stringValue
                            let title = article.1["title"].stringValue
                            let url = article.1["url"].stringValue
                            let publishedAt = article.1["publishedAt"].stringValue
        
                            DispatchQueue.main.async {
                                self.newsArticle += [NewsArticle(id: id, title: title, url: url, publishedAt: publishedAt)]
                            }
                            
                            
                        }
                    }
                    
                    DispatchQueue.main.async { [self] in
                        completion(.success(newsArticle))
                    }
        
                }.resume()
            } else {
                
                currentPage += 1
                let source = "https://newsapi.org/v2/everything?sources=\(newsSourceID)&page=\(currentPage)&apiKey=4a17051ecc0d43819c8d157215e9a9db"
                let url = URL(string: source)!
                let session = URLSession(configuration: .default)
        
                session.dataTask(with: url) { data, _, error in
        
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
        
                    }

                    if let newsAPI = try? JSON(data: data!) {
                        
                        let articles = newsAPI["articles"]
        
                        for article in articles {
                            let id = article.1["source"]["id"].stringValue
                            let title = article.1["title"].stringValue
                            let url = article.1["url"].stringValue
                            let publishedAt = article.1["publishedAt"].stringValue
        
                            DispatchQueue.main.async {
                                self.newsArticle += [NewsArticle(id: id, title: title, url: url, publishedAt: publishedAt)]
                            }
                            
                            
                        }
                    }
                    
                    DispatchQueue.main.async { [self] in
                        completion(.success(newsArticle))
                    }
        
                }.resume()
            }
                    
            if pagination {
                self.isPaginating = false
            }
        })
    }
    
    func articleTotal() -> Int {
        newsArticle.count
    }
    
    func articleName(at indexPath: IndexPath) -> String {
        newsArticle[indexPath.row].title
    }
    
    func addData(data: [NewsArticle]) {
        self.newsArticle.append(contentsOf: data)
    }
    
    func getPaginatingStatus() -> Bool {
        isPaginating
    }
    
    func openArticle(at indexPath: IndexPath) {
        let articleURL = newsArticle[indexPath.row].url
        presenter.routeToWebView(with: articleURL)
    }
    
    func searchBarActive(searchText: String, newsSourceID: String, elseRun: @escaping ()->()) {
        
        searchBarText = searchText
        
        if searchBarText != "" {
            
            let source = "https://newsapi.org/v2/everything?sources=\(newsSourceID)&q=\(searchText)&searchIn=title&apiKey=4a17051ecc0d43819c8d157215e9a9db"
            let url = URL(string: source)!
            let session = URLSession(configuration: .default)
            newsArticle = []
            
            session.dataTask(with: url) { data, _, error in
                
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                    
                }
                
                if let newsAPI = try? JSON(data: data!) {
                    
                    let articles = newsAPI["articles"]
    
                    for article in articles {
                        let id = article.1["source"]["id"].stringValue
                        let title = article.1["title"].stringValue
                        let url = article.1["url"].stringValue
                        let publishedAt = article.1["publishedAt"].stringValue
    
                        DispatchQueue.main.async {
                            self.newsArticle += [NewsArticle(id: id, title: title, url: url, publishedAt: publishedAt)]
                        }
                        
                        
                    }
                }
                
                DispatchQueue.main.async {
                    self.presenter.reloadnewsArticle()
                }
                
            }.resume()
        } else {
            newsArticle = []
            elseRun()
        }
    }
    
    func getSearchBarText() -> String {
        searchBarText
    }
}
