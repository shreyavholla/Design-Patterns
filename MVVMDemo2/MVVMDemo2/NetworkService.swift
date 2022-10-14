//
//  NetworkService.swift
//  MVVMDemo2
//
//  Created by admin on 04/10/22.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    var user : User?
    
    private init() {}
    
    func register(firstname: String, lastname: String, email: String, password: String) -> User?{
        
        
        self.user = User(firstname: firstname, lastname: lastname, email: email, password: password)
        
        return user
    }
    
    func validatePassword(password: String, conpass: String) -> Bool{
        
        if password == conpass {
            return true
        }
        
        return false
    }
    
    func login(email: String, password: String, completion: @escaping(Bool)-> Void){
        
        if email == user?.email && password == user?.password{
            print("Logged in successfully")
            completion(true)
        }else{
            print("wrong user or password")
            completion(false)
        }
        
        
    }
    
    func getLoggedInUserDetails() -> User?{
        
        guard let user = user else{
            return nil
        }
        
        return user
    }
    
}
