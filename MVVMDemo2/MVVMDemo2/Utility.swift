//
//  Utility.swift
//  MVVMDemo2
//
//  Created by admin on 08/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(msg: String, title: String){
        
        let actionVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default)
        actionVC.addAction(OkAction)
        present(actionVC, animated: false)
    }
    
}
