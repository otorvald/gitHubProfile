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
        
        performSegue(withIdentifier: "showProfile", sender: self);
    }
    

}
