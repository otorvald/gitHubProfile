//
//  AuthViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 8/1/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    var webView : UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Authentication"
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        leftBarButtonItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        
        UINavigationBar.appearance().tintColor = UIColor.init(red: 63/255.0, green:68/255.0 , blue: 83/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:143/255.0, green:0/255.0, blue:244/255.0, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:143/255.0, green:0/255.0, blue:244/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        webView.delegate = self
        
        let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(Api.clientId)&redirect_url=\(Api.redirectUrl)&scope=user")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil);
    }
    

}

extension AuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if (request.url?.absoluteString.contains("code="))! { //Get code from urlString
            let components = request.url?.absoluteString.components(separatedBy: "code=")
            let loginViewController = self.presentingViewController as! LoginViewController
            dismiss(animated: true) {
                loginViewController.code = components?.last
            }
        }
        
        return true
    }
}
