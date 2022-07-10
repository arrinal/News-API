//
//  NewsSourceView.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import UIKit

protocol NewsSourceViewProtocol {
    
    func reloadNewsSource()
    
}

class NewsSourceView: UIViewController, NewsSourceViewProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var categoryName: String!
    var presenter: NewsSourcePresenterInput!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "newsSourceCell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        presenter.fetchNewsSource(for: categoryName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func reloadNewsSource() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.newsSourceTotal()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsSourceCell", for: indexPath)
        cell.textLabel?.text = presenter.newsSourceName(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.discoverNewsArticle(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
