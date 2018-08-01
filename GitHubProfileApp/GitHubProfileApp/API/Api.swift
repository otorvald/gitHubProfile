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
    public static let baseURLString = "https://github.com/"
    
    struct login {
        static let url = baseURLString + "login/oauth/access_token"
        
        struct params {
            static let clientId = "client_id"
            static let clientSectet = "client_secret"
            static let code = "code"
        }
    }
    
    struct user {
        static let url = baseAPIURLString + "user"
        
        struct params {
            static let name = "name"
            static let blog = "blog"
            static let company = "company"
            static let location = "location"
            static let bio = "bio"
        }
        
        struct headers {
            static let authorization = "Authorization"
        }
    }
    
}
