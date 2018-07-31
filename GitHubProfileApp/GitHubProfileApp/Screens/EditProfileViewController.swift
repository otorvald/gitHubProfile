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
    
    var textFiels = [UITextField]()
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.makeToast("Fill the fields you need to update", duration: 4, position: .bottom)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        //TODO: Try to optimize
        var newName : String?
        var newBlog : String?
        var newCompany : String?
        var newLocation : String?
        var newBio : String?
        
        if !(self.textFiels[0].text?.isEmpty)! {
            newName = self.textFiels[0].text
        }
        if !(self.textFiels[1].text?.isEmpty)! {
            newBlog = self.textFiels[1].text
        }
        if !(self.textFiels[2].text?.isEmpty)! {
            newCompany = self.textFiels[2].text
        }
        if !(self.textFiels[3].text?.isEmpty)! {
            newLocation = self.textFiels[3].text
        }
        if self.textView?.text != self.user?.bio {
            newBio = self.textView?.text
        }
        
        
        ApiManager.sharedManager.patchUser(name: newName, blog: newBlog, company: newCompany, location: newLocation, bio: newBio, completion: { user in
            
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
        cell.textField.delegate = self
        self.textFiels.append(cell.textField)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return self.heightForTextViewCell
        }
        
        return self.heightForTextFieldCell
    }
}
