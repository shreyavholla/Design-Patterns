//
//  LoginViewController.swift
//  MVVMDemo2
//
//  Created by admin on 04/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailL: UITextField!
    
    @IBOutlet weak var passwordL: UITextField!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    private func setupBinders(){
        
        viewModel.error.bind {  err in
            if let err = err {
                self.showAlert(msg: "Renter login and password", title: err.description)
            }else {
                
                self.goToHomePage()
            }
        }
    }
    
    func goToHomePage(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        present(vc, animated: false)
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        
        guard let email = emailL.text,
              let pass = passwordL.text else {
            
            showAlert(msg: "User ID not registered, kindly register first", title: "")
            return
        }
        
        if(email.isEmpty || pass.isEmpty){
            showAlert(msg: "Please fill all the details", title: "Empty Fields")
        }
        
        viewModel.login(email: email, password: pass)
        setupBinders()
        print("login button clicked")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
