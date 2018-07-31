//
//  User.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/31/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import Foundation

class User {
    
    fileprivate static let imageDataKey = "avatar_url"
    fileprivate static let nameKey = "name"
    fileprivate static let loginKey = "login"
    fileprivate static let emailKey = "email"
    fileprivate static let blogKey = "blog"
    fileprivate static let companyKey = "company"
    fileprivate static let locationKey = "location"
    fileprivate static let bioKey = "bio"
    
    var imageData : Data?
    var name : String?
    var login : String?
    var email : String?
    var blog : String?
    var company : String?
    var location : String?
    var bio : String?
    
    init(imageDataString: String?, name : String?, login: String?, email: String?, blog : String?, company : String?, location : String?, bio : String? ) {
        self.imageData = imageDataString?.getPhotoData()
        self.name = name
        self.login = login
        self.email = email
        self.blog = blog
        self.company = company
        self.location = location
        self.bio = bio
    }
    
    convenience init(initWithDictionary dictionary: [String:Any]) {
        
        let imageDataString = dictionary[User.imageDataKey] as? String
        let name = dictionary[User.nameKey] as? String
        let login = dictionary[User.loginKey] as? String
        let email = dictionary[User.emailKey] as? String
        let blog = dictionary[User.blogKey] as? String
        let company = dictionary[User.companyKey] as? String
        let location = dictionary[User.locationKey] as? String
        let bio = dictionary[User.bioKey] as? String
        
        self.init(imageDataString: imageDataString, name: name, login: login, email: email, blog: blog, company: company, location: location, bio: bio)
    }
}
