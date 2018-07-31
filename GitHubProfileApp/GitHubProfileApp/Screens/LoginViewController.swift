//
//  LoginViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var authenticatinLabel: UILabel!
    @IBOutlet weak var authenticatingActivityIndicator: UIActivityIndicatorView!
    
    var user : User? {
        didSet {
            performSegue(withIdentifier: "showProfile", sender: self);
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
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        self.authenticatinLabel.isHidden = false;
        self.authenticatingActivityIndicator.isHidden = false;
        
        ApiManager.sharedManager.getUser(completion: {user in
            self.user = user;
        }, errorWithCode: {errorCode in
            print("Auth error with code: \(String(describing: errorCode))")
            self.authenticatinLabel.isHidden = true;
            self.authenticatingActivityIndicator.isHidden = true;
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile" {
            let navigationController = segue.destination as! UINavigationController
            let profileViewController = navigationController.viewControllers.last as! ProfileViewController
            
            profileViewController.user = self.user
        }
    }

}
