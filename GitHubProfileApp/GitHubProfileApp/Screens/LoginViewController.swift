//
//  LoginViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var authenticatinLabel: UILabel!
    @IBOutlet weak var authenticatingActivityIndicator: UIActivityIndicatorView!
    
    var code : String? {
        didSet {
            self.showAuthProcessIndicators()
            
            ApiManager.sharedManager.login(code: code!, completion: { tokenResponse in
                if let token = tokenResponse {
                    UserDefaultsManager.storeUserToken(token)
                    self.getUser(token: token)
                }
            }) { errorCode in
                if let err = errorCode {
                    print("Token error with code: \(String(describing: err))")
                    self.view.makeToast("Auth error with code: \(String(describing: err))", duration: 3, position: .bottom)
                }
                self.hideAuthProcessIndicators()
            }
        }
    }
    
    var user : User? {
        didSet {
            performSegue(withIdentifier: "login-profile", sender: self);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.layer.cornerRadius = self.loginButton.bounds.height/2;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.authenticatinLabel.isHidden = true;
        self.authenticatingActivityIndicator.isHidden = true;
    }
    
    func showAuthProcessIndicators() {
        self.authenticatinLabel.isHidden = false;
        self.authenticatingActivityIndicator.isHidden = false;
    }
    
    func hideAuthProcessIndicators() {
        self.authenticatinLabel.isHidden = true;
        self.authenticatingActivityIndicator.isHidden = true;
    }
    
    func getUser(token: String) {
        ApiManager.sharedManager.getUser(token: token, completion: {user in
            self.user = user;
        }, errorWithCode: {errorCode in
            if let err = errorCode {
                print("Auth error with code: \(String(describing: err))")
                self.view.makeToast("Auth error with code: \(String(describing: err))", duration: 3, position: .bottom)
            }
            self.hideAuthProcessIndicators()
        })
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let authViewController = AuthViewController()
        let navigationController = UINavigationController(rootViewController: authViewController)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login-profile" {
            let navigationController = segue.destination as! UINavigationController
            let profileViewController = navigationController.viewControllers.last as! ProfileViewController
            
            profileViewController.user = self.user
        }
    }

}
