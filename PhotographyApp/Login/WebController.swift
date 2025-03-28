//
//  WebController.swift
//  PhotographyApp
//
//  Created by Elsever on 28.03.25.
//

import UIKit
import WebKit

class WebController: UIViewController, WKUIDelegate {

    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        openUrl()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    func openUrl() {
        let myURL = URL(string:"https://unsplash.com/oauth/authorize?client_id=x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&scope=public+read_user+write_user")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
    }

}

extension WebController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        if let finalURL = webView.url, finalURL.absoluteString.contains("/native") {
            print("Final URL after redirection: \(finalURL.absoluteString)")
            dismiss(animated: true)
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func find(
        _ string: String,
        configuration: WKFindConfiguration = .init(),
        completionHandler: @escaping @MainActor (WKFindResult) -> Void
    ) {
    }
    
}
