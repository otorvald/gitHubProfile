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
    
    let clientId = "97aa498152405ea6b3c9"
    let clientSecret = "f451b032ef8ed1cd8b8b2ef52939d24dd2d939f5"
    
    private init() {}
    
    
    func login(code: String, completion: @escaping (String?) -> (), errorWithCode: @escaping (Int?) -> ()) {
        
        let params = [Api.login.params.clientId: self.clientId,
                      Api.login.params.clientSectet: self.clientSecret,
                      Api.login.params.code: code]
        
        Alamofire.request(Api.login.url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseString { response in
                
                if response.response?.statusCode == 200 {
                    
                    if let responseString = response.result.value {
                        let components = responseString.components(separatedBy: "&scope")
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
    
    
    func patchUser(name: String? = nil,
                   blog: String? = nil,
                   company: String? = nil,
                   location: String? = nil,
                   bio: String?,
                   token: String,
                   completion: @escaping (User?) -> (),
                   errorWithCode: @escaping (Int?) -> ()) {
        
        let headers = [Api.user.headers.authorization : "Bearer \(token)"]
        var params = [String:String]()
        
        if name != nil {
            params[Api.user.params.name] = name;
        }
        
        if blog != nil {
            params[Api.user.params.blog] = blog;
        }
        
        if company != nil {
            params[Api.user.params.company] = company;
        }
        
        if location != nil {
            params[Api.user.params.location] = location;
        }
        
        if bio != nil {
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


//    func login(username: String, password: String) {
//
//        let optData = "\(username):\(password)".data(using: String.Encoding.utf8)
//        if let data = optData {
//            basicAuth = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
//        }
//
//        //let params = ["scopes":["user"], "note": "profile_app", "client_id": clientId, "client_secret": clientSecret] as [String : Any]
//
//        Alamofire.request("https://api.github.com/user", method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": "Bearer \(basicAuth)"]) .responseJSON(completionHandler: { json in
//            print(json)
//        })
//
//    }
