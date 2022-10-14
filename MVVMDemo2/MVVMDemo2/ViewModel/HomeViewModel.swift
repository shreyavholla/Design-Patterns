//
//  HomeViewModel.swift
//  MVVMDemo2
//
//  Created by admin on 04/10/22.
//

import Foundation

final class HomeViewModel{
    
    var welcomeMsg : ObservableObject<String?> = ObservableObject(nil)
    
    func getLoggedInUserDetails(){
        
        let user = NetworkService.shared.getLoggedInUserDetails()
        self.welcomeMsg.value = "Hello, \(user?.firstname ?? "") \(user?.lastname ?? "")"
    }
    
}
