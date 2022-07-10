//
//  ArticleWebView.swift
//  News API
//
//  Created by Arrinal Sholifadliq on 10/07/22.
//

import UIKit
import WebKit

class ArticleWebView: UIViewController, WKUIDelegate {
    
    let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
        
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    var presenter: ArticleWebPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        loadUrl()
    }
    
    func setupUI() {
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .white
    
    }
    
    func loadUrl()
    {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        webView.load(request)
    }
}
