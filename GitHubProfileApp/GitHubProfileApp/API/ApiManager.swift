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
    let personalToken = "dabd46b118c9fb0838b0fd6d90173faa04f19578"
    
    private init() {}
    
    func getUser(completion: @escaping (User?) -> ()) {
        
        let headers = [Api.user.headers.authorization : "Bearer \(self.personalToken)"]
        
        Alamofire.request(Api.user.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                
                if let error = response.error {
                    print(error)
                } else {
                    var user : User?
                    
                    if let dictionary = response.result.value as? [String:Any] {
                        user = User(initWithDictionary: dictionary)
                    }
                    
                    completion(user)
                }
        }
    }
    
    func patchUser(name: String? = nil, blog: String? = nil, completion: @escaping (Bool) -> ()) {
        
        let headers = [Api.user.headers.authorization : "Bearer \(self.personalToken)"]
        var params = [String:String]()
        
        if name != nil {
            params[Api.user.params.name] = name;
        }
        
        if blog != nil {
            params[Api.user.params.blog] = blog;
        }
        
        Alamofire.request(Api.user.url, method: .patch, parameters: params, encoding: URLEncoding.default, headers: headers)
            .response { response in
                if let error = response.error {
                    print(error)
                    completion(false)
                } else {
                    completion(true)
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
