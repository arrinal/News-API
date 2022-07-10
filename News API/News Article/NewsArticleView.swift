//
//  NewsArticleView.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import UIKit

protocol NewsArticleViewProtocol {
    func reloadnewsArticle()
}

class NewsArticleView: UIViewController, NewsArticleViewProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate {
    
    var newsSourceID: String!
    var presenter: NewsArticlePresenterInput!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "newsArticleCell")
        table.rowHeight = UITableView.automaticDimension
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        searchBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        presenter.fetchArticle(pagination: false, for: newsSourceID) { result in
            switch result {
            case .success(let data):
                self.presenter.addData(data: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                break
            }
        }
    }
    
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 5).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func reloadnewsArticle() {
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarActive(searchText: searchText, newsSourceID: newsSourceID) { [self] in
            presenter.fetchArticle(pagination: false, for: newsSourceID) { result in
                switch result {
                case .success(let data):
                    self.presenter.addData(data: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.articleTotal()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsArticleCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = presenter.articleName(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openArticle(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            
            guard presenter.getSearchBarText() == "" else { return }
            guard !presenter.getPaginatingStatus() else { return }
            
            self.tableView.tableFooterView = createSpinnerFooter()
            
            presenter.fetchArticle(pagination: true, for: newsSourceID) { [weak self] result in
                
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                
                switch result {
                case .success(let moreData):
                    self?.presenter.addData(data: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
    }

}
