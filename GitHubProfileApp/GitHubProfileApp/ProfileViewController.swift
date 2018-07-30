//
//  ProfileViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageBorderView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileNickNameLabel: UILabel!
    @IBOutlet weak var profileBioLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profileSiteLabel: UILabel!
    @IBOutlet weak var profileCompanyLabel: UILabel!
    @IBOutlet weak var profileLocationLabel: UILabel!
    
    let menuItems = ["Resourses", "Stars", "Followers", "Following"]
    
    let tableViewRowHeight : CGFloat = 45
    
    let cellIdentifier = "cellIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeInitialCustomization()
    }
    
    
    func makeInitialCustomization() {
        
        UINavigationBar.appearance().tintColor = UIColor.init(red: 63/255.0, green:68/255.0 , blue: 83/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:143/255.0, green:0/255.0, blue:244/255.0, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:143/255.0, green:0/255.0, blue:244/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.scrollView.bounces = false
        
        self.profileImageView.layoutIfNeeded()
        self.profileImageBorderView.layoutIfNeeded()
        
        self.profileImageBorderView.layer.cornerRadius = self.profileImageBorderView.frame.height/2
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2
        
        self.tableViewHeightConstraint.constant = self.tableViewRowHeight * CGFloat(self.menuItems.count)
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil);
        } else {
            print("NEMA")
        }
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showEditProfile", sender: self)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.menuItems[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight
    }
    
}
