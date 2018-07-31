//
//  EditProfileViewController.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageViewBorder: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    let textFieldCellIdentifier = "textFieldCell"
    let textViewCellIdentifier = "textViewCell"
    
    let menuItems = ["Name", "Blog", "Company", "Location", "Bio"]
    let textFieldPlaceholders = ["Name or nickname", "Example.com", "Company name", "City"];
    
    let heightForTextFieldCell : CGFloat = 40;
    let heightForTextViewCell : CGFloat = 150;
    
    let bioMaxLength = 100;
    let textFieldMaxLength = 25;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.bounces = false;
        
        self.profileImageViewBorder.layoutIfNeeded()
        self.profileImageView.layoutIfNeeded()
        self.profileImageViewBorder.layer.cornerRadius = self.profileImageViewBorder.frame.height/2;
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2;

    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
    }
    
    func moveViewUp() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
        })
    }
    
    func moveViewDown() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
        })
    }
    
}

extension EditProfileViewController: UITextViewDelegate {
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        self.moveViewUp()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.moveViewDown()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.moveViewUp()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveViewDown()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
        cell.label.text = self.menuItems[indexPath.row];
        cell.textField.placeholder = self.textFieldPlaceholders[indexPath.row];
        cell.textField.delegate = self;
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return self.heightForTextViewCell;
        }
        
        return self.heightForTextFieldCell;
    }
}
