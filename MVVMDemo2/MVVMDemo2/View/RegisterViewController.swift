//
//  RegisterViewController.swift
//  MVVMDemo2
//
//  Created by admin on 04/10/22.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var firstnameL: UITextField!
    
    @IBOutlet weak var lastnameL: UITextField!
    
    @IBOutlet weak var emailL: UITextField!
    
    @IBOutlet weak var passwordL: UITextField!
    
    @IBOutlet weak var confirmPasswordL: UITextField!
    
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       //
    }
    
   
    private func setupBinders(){
        
        viewModel.error.bind {  error in
            if let error = error {
                print("Error : \(error.description)")
            }else {
               
                self.goToLogin()
                print("All okay")
            }
        }
    }
    
    func goToLogin(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController

        present(vc, animated: false)
        
//        UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
//        [top presentViewController:LoginViewController animated:YES completion: nil]
//
//        UIViewController *top = [UIApplication]
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view = storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //show window
//        appDelegate.window?.rootViewController = view
    }
    
    @IBAction func registerBtnClciked(_ sender: Any) {
        
        
        guard let fname = firstnameL.text,
              let lname = lastnameL.text,
              let email = emailL.text,
              let pass = passwordL.text,
              let conpass = confirmPasswordL.text else {
            
            return
            
        }
        
        if(fname.isEmpty || lname.isEmpty || email.isEmpty || pass.isEmpty || conpass.isEmpty)
        {
            showAlert(msg: "Please fill all the details", title: "Empty Fields")
        }else{
            
           let validate = viewModel.validatePassword(password: pass, conpass: conpass)
            
            if validate{
                viewModel.register(firstname: fname, lastname: lname, email: email, password: pass)
                setupBinders()
            }else{
                
                showAlert(msg: "Please renter the password", title: "Password Mismatch")
            }
        }
        
        
        
        
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
