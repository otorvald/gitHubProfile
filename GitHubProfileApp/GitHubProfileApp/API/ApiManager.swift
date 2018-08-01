//
//  ApiManager.swift
//  GitHubProfileApp
//
//  Created by Maksym Bystryk on 7/30/18.
//  Copyright © 2018 max.bystryk. All rights reserved.
//

import Alamofire

class ApiManager {
    
    static let sharedManager = ApiManager()
    
    private init() {}
    
    
    func login(code: String, completion: @escaping (String?) -> (), errorWithCode: @escaping (Int?) -> ()) {
        
        let params = [Api.login.params.clientId: Api.clientId,
                      Api.login.params.clientSectet: Api.clientSecret,
                      Api.login.params.code: code]
        
        Alamofire.request(Api.login.url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseString { response in
                
                if response.response?.statusCode == 200 {
                    
                    if let responseString = response.result.value {
                        let components = responseString.components(separatedBy: "&scope") //Get token from response
                        let token = components.first?.deletingPrefix("access_token=")
                        
                        completion(token)
                    }
                }
                else {
                    errorWithCode(response.response?.statusCode)
                }
        }
        
    }
    
    
    func getUser(token: String, completion: @escaping (User?) -> (), errorWithCode: @escaping (Int?) -> ()) {
        
        let headers = [Api.user.headers.authorization : "Bearer \(String(describing: token))"]
        
        Alamofire.request(Api.user.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                
                if (response.response?.statusCode == 200) {
                    if let dictionary = response.result.value as? [String:Any] {
                        let user = User(initWithDictionary: dictionary)
                        completion(user)
                    }
                } else {
                    
                    if let error = response.error {
                        print(error)
                    } else {
                        
                        errorWithCode(response.response?.statusCode)
                    }
                }
        }
    }
    
    
    func patchUser(user: User, token: String, completion: @escaping (User?) -> (), errorWithCode: @escaping (Int?) -> ()) {
        
        let headers = [Api.user.headers.authorization : "Bearer \(token)"]
        var params = [String:String]()
        
        if let name = user.name {
            params[Api.user.params.name] = name;
        }
        
        if let blog = user.blog {
            params[Api.user.params.blog] = blog;
        }
        
        if let company = user.company {
            params[Api.user.params.company] = company;
        }
        
        if let location = user.location {
            params[Api.user.params.location] = location;
        }
        
        if let bio = user.bio {
            params[Api.user.params.bio] = bio;
        }
        
        Alamofire.request(Api.user.url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                if response.response?.statusCode == 200 {
                    if let dictionary = response.result.value as? [String:Any] {
                        let user = User(initWithDictionary: dictionary)
                        completion(user)
                    }
                }
                else {
                    errorWithCode(response.response?.statusCode)
                }
        }
    }
}


extension String {
    
    func getPhotoData() -> Data? {
        do {
            if let url = URL(string: self) {
                return try Data(contentsOf: url)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deleteSufix(_ sufix: String) -> String {
        guard self.hasSuffix(sufix) else { return self }
        return String(self.dropLast(sufix.count))
    }
}
