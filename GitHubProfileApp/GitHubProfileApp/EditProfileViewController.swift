//
//  EditProfileViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageViewBorder: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    let textFieldCellIdentifier = "textFieldCell"
    let textViewCellIdentifier = "textViewCell"
    
    let menuItems = ["Name", "Blog", "Company", "Location", "Bio"]
    let textFieldPlaceholders = ["Name or Nickname", "example.com", "Company name", "City"];
    
    let heightForTextFieldCell : CGFloat = 40;
    let heightForTextViewCell : CGFloat = 120;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
    }
    
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.textViewCellIdentifier, for: indexPath) as! TextViewTableViewCell
            cell.label.text = self.menuItems[indexPath.row]
            cell.textView.delegate = self;
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
        cell.label.text = self.menuItems[indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return self.heightForTextViewCell;
        }
        
        return self.heightForTextFieldCell;
    }
}
