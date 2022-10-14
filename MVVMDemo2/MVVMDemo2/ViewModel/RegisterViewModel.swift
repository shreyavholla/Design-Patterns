//
//  RegisterViewModel.swift
//  MVVMDemo2
//
//  Created by admin on 04/10/22.


import Foundation

final class RegisterViewModel {
    
    var error : ObservableObject<String?> = ObservableObject(nil)
    
    func validatePassword(password: String, conpass: String) -> Bool{
        
        let validate = NetworkService.shared.validatePassword(password: password, conpass: conpass)
        
        return validate
    }
    
    func register(firstname: String, lastname: String, email: String, password: String){
        
        
        let user = NetworkService.shared.register(firstname: firstname, lastname: lastname, email: email, password: password)
        
        print(user ?? "")
    }
    
}

