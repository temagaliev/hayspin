//
//  PrivacyPolicyViewController.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = URL(string: "https://docs.google.com/document/d/1V5TrKmWAYIf-PUHaENdB4cecULDKh5w-1JDLqcuSDTU/edit?usp=sharing")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func onBackButtonClick() {
        MainRouter.shared.closeTermsViewScreen()
    }
}
