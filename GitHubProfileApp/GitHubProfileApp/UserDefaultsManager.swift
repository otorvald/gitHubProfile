//
//  UserDefaultsManager.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 8/1/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    private static let tokenKey = "tokenKey"
    
    
    static func getUserToken() -> String? {
        
        let preferences = UserDefaults.standard
        
        var token: String?
        
        if preferences.object(forKey: tokenKey) != nil {
            token = preferences.string(forKey: tokenKey)
        }
        
        return token
    }
    
    
    static func storeUserToken(_ token: String?) {
        
        let preferences = UserDefaults.standard
        
        preferences.set(token, forKey: tokenKey)
        
        preferences.synchronize()
    }
    
    
    static func removeUserToken() {
        
        let preferences = UserDefaults.standard
        
        preferences.removeObject(forKey: tokenKey)
        
        preferences.synchronize()
    }
}
