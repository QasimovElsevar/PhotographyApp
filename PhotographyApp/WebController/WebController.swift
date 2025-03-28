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
    
    var callback: ((String) -> Void)?
    
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
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let finalURL = webView.url, finalURL.absoluteString.contains("/native") {
            print("Final URL after redirection: \(finalURL.absoluteString)")
            print(finalURL.lastPathComponent)
            print(finalURL.pathComponents)
            let code = finalURL.absoluteString.split(separator: "=").last ?? ""
            dismiss(animated: true)
            callback?(String(code))
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}
