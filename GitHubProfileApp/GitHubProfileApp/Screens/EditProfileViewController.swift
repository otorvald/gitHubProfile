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
    let textFieldPlaceholders = ["Name or nickname", "Example.com", "Company name", "City"]
    
    var textFieldsText = [String?]()
    
    var textFields = [UITextField]()
    var textView : UITextView?
    
    let heightForTextFieldCell : CGFloat = 40
    let heightForTextViewCell : CGFloat = 150
    
    let bioMaxLength = 100
    let textFieldMaxLength = 25
    
    var user : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.bounces = false
        
        self.profileImageViewBorder.layoutIfNeeded()
        self.profileImageView.layoutIfNeeded()
        self.profileImageViewBorder.layer.cornerRadius = self.profileImageViewBorder.frame.height/2;
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2;
        
        if let data = user?.imageData {
            self.profileImageView.image = UIImage(data: data)
        }
        
        self.textFieldsText.append(user?.name)
        self.textFieldsText.append(user?.blog)
        self.textFieldsText.append(user?.company)
        self.textFieldsText.append(user?.location)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        self.user?.name = self.textFields[0].text
        self.user?.blog = self.textFields[1].text
        self.user?.company = self.textFields[2].text
        self.user?.location = self.textFields[3].text
        self.user?.bio = self.textView?.text
        
        if let token = UserDefaultsManager.getUserToken() {
            
            ApiManager.sharedManager.patchUser(user: self.user!, token: token, completion: { user in
                
                let profileViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! ProfileViewController
                profileViewController.user = user
                profileViewController.updateUserProperties()
                self.view.makeToast("Profile successfully updated")
            }, errorWithCode: { errorCode in
                if let err = errorCode {
                    print("Patching error with code \(String(describing: err))")
                    self.view.makeToast("Request error with code: \(String(describing: err))", duration: 3, position: .bottom)
                }
            })
            
        }
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
            cell.textView.text = self.user?.bio
            cell.textView.delegate = self
            self.textView = cell.textView
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
        cell.label.text = self.menuItems[indexPath.row]
        cell.textField.placeholder = self.textFieldPlaceholders[indexPath.row]
        cell.textField.text = self.textFieldsText[indexPath.row]
        cell.textField.delegate = self
        self.textFields.append(cell.textField)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return self.heightForTextViewCell
        }
        
        return self.heightForTextFieldCell
    }
}
