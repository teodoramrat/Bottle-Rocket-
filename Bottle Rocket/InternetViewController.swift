//
//  ViewController2.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit
import WebKit

class InternetViewController: UIViewController, WKNavigationDelegate {
    private let appHomePage: String = "https://www.bottlerocketstudios.com"
    private let webView: WKWebView = WKWebView()
    private lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webBack), style: .plain, target: webView, action: #selector(webView.goBack))
        backButton.isEnabled = false
        return backButton
    }()
    
    private lazy var refreshButton: UIBarButtonItem = {
        let refreshButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webRefresh), style: .plain, target: webView, action: #selector(webView.reload))
        refreshButton.isEnabled = false
        return refreshButton
    }()
    
   private lazy var forwardButton: UIBarButtonItem = {
        let forwardButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webForward), style: .plain, target: webView, action: #selector(webView.goForward))
        forwardButton.isEnabled = false
        return forwardButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        loadWebPage()
    }
    
    override func loadView() {
        view = UIView()
        setupWebView()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    fileprivate func loadWebPage() {
        guard let url = URL(string: appHomePage) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .appColor(.navBarGreen)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItems = [backButton, refreshButton, forwardButton]
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        refreshButton.isEnabled = true
    }
}
