//
//  WebController.swift
//  PhotographyApp
//
//  Created by Elsever on 28.03.25.
//

import UIKit
import WebKit

final class WebController: UIViewController, WKUIDelegate {

    //MARK: -UI Elements
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    //MARK: - Properties
    
    let viewModel: WebViewModel
    var callback: (() -> Void)?
    
    init(viweModel: WebViewModel) {
        self.viewModel = viweModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        openUrl()
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.addSubview(webView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}

extension WebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if let finalURL = webView.url, finalURL.absoluteString.contains("/native") {
            let code = webView.url?.absoluteString.split(separator: "code=").last ?? ""
            
            UserDefaults.standard.set(code, forKey: "code")
            
            dismiss(animated: true) { [weak self] in
                NotificationCenter.default.post(name: .webViewDismissed, object: nil)
                self?.callback?()
            }
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}

extension WebController {
    
    private func openUrl() {
        let urlString = "https://unsplash.com/oauth/authorize?client_id=x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&scope=public+read_user+write_user+read_user+write_likes+write_followers+read_collections+write_collections+read_photos+write_photos"
        
        let myURL = URL(string: urlString)
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
    }
}
