//
//  SplashViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 8/1/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var user : User?
    
    override func viewDidAppear(_ animated: Bool) {
        if let token = UserDefaultsManager.getUserToken() {
            ApiManager.sharedManager.getUser(token: token, completion: { user in
                self.user = user
                self.showProfile()
            }) { (errorCode) in
                print("token expired")
                self.showLogin()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showLogin()
            }
        }
    }
    
    func showLogin() {
        performSegue(withIdentifier: "splash-login", sender: self)
    }
    
    func showProfile() {
        performSegue(withIdentifier: "splash-profile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "splash-profile" {
            let navigationViewController = segue.destination as! UINavigationController;
            let profileViewController = navigationViewController.viewControllers.first as! ProfileViewController
            profileViewController.user = self.user
        }
    }
}
