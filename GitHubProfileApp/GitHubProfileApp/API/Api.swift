//
//  Api.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import Foundation

class Api {
    
    public static let baseAPIURLString = "https://api.github.com/"
    
    struct login {
        static let url = baseAPIURLString + "user/login/"
        
        struct params {
            static let username = "username"
            static let password = "password"
        }
    }
    
}
