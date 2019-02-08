//
//  ViewController.swift
//  WebView
//
//  Created by SOTSYS008 on 06/02/19.
//  Copyright © 2019 SOTSYS008. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController,UIWebViewDelegate{
    
    //MARK: Declare IBOutlets
    @IBOutlet var webView : WKWebView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var layoutTextField: NSLayoutConstraint!
    
    var myActivityIndicator = UIActivityIndicatorView()
    
    
    //Mark: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 12
        searchButton.clipsToBounds = true
        
        btnBack.layer.cornerRadius = 15
        btnNext.clipsToBounds = true
        
        btnNext.layer.cornerRadius = 15
        btnNext.clipsToBounds = true
        
        //MARK: - Create Custom ActivityIndicator
        myActivityIndicator.center = self.view.center
        myActivityIndicator.style = .gray
        view.addSubview(myActivityIndicator)
        
        //Adding observer for show loading indicator
        self.webView.addObserver(self, forKeyPath:#keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    
    //Mark: Search Using google query url
    @IBAction func btnSearchAction(_ sender: UIButton) {
        func searchTextOnGoogle(text: String){
            let textComponent = text.components(separatedBy: " ")
            let searchString = textComponent.joined(separator: "+")
            let url = URL(string: "https://www.google.com/search?q=" + searchString)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
        if let urlString = searchTextField.text{
            if urlString.starts(with: "http://") || urlString.starts(with: "https://"){
                webView.loadUrl(string: urlString)
            }else if urlString.contains("www"){
                webView.loadUrl(string: "http://\(urlString)")
            }else{
                searchTextOnGoogle(text: urlString)
            }
        }
    }
    
    
    //Mark: Go previous page of Webview
    @IBAction func btnBackAction(_ sender: UIButton) {
        webView.goBack()
    }
    
    //Mark: Go next page of Webview
    @IBAction func btnNextAction(_ sender: Any) {
        webView.goForward()
    }
    
    
    //MARK: - ActivityIndicator StartAnimate And StopAnimate
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading"{
            if webView.isLoading{
                myActivityIndicator.startAnimating()
                myActivityIndicator.isHidden = false
            }else{
                myActivityIndicator.stopAnimating()
            }
        }
    }
}
//MARK: - Load Url In Webview
extension WKWebView {
    func loadUrl(string: String) {
        if let url = URL(string: string) {
            load(URLRequest(url: url))
        }
    }
}
