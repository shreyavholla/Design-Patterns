# MVVM - Model View ViewModel



[![Screenshot-2022-10-04-at-10-39-18-AM.png](https://i.postimg.cc/TwC2Pt3r/Screenshot-2022-10-04-at-10-39-18-AM.png)](https://postimg.cc/xJNVxyHC)

Here,

- The Model : represents the data

  - data
  - actions
  - The model can notify the viewModel if changes are made.

- View : what the user can see in the screen

  - Buttons
  - Text fields
  - switch controls
  - the view is **aware** of the viewModel

- **ViewModel** : a model for a specific view

  - Contains the business logic

  - Updates the view using a **binder** (since the viewModel is not aware to the view)

  - But the viewModel is not aware of the view

  - The viewModel is completely **independent** of the view

  - every view has its own view model

  - all attributes and methods directly related to the method itself will be presented to a view

  - The view has no idea what is happening to the model

  - The viewModel has only those objects and attributes that the view needs.

    

  - The viewModel is aware of the changes made in the Model

  - it can update and retrive data to the model



Swift file--- User.swift --- Model

```swift
import Foundation

struct User {
  
  let firstname: String
  let lastname: String
  let email: String
  let age: Int
}
```

Swift File --- LoginViewModel.swft ---- ViewModel

LoginView : LoginViewController & LoginViewModel

Implementing Binding :

- Observable
- Event Bus
- RX coco
- Combine

Here, we will be using an observable : it will send a notification the view whenever changes are made to a partivular object or attribute.

```swift
import Foundation
final class LoginViewModel {
  
  //Implementing Binding --- Observable
  
}
```



Creating an observable object class -- swift file (ObservableObject.swift)

```swift
import Foundation

//making it generic
final class ObservableObject<T> {
  //making it optional to support a nil value
   var value : T{
    //whenever the value is changed the listener value is updated
     didSet {
       listener?(value)
     }
   }
  private var listener: ((T) -> Void)?
  init(_ value: T) {
    
    self.value = value
  }
  
  //making a binding function and adding a listner and returning a value
  func bind(_ listener : @escaping(T) -> Void){
    
    listener(value)
    //set our listener to the closure passed in
    self.listener = listener 
    
  }
}
```



Creating an instance of the ViewModel in the LoginViewController

```swift
import UIKit

class LoginViewController : UIViewController {
  
  private let viewModel = LoginViewModel()
  
  override func viewDidLoad(){
    super.viewDidLoad()
  }
     
  }
  @IBAction func loginBtnClicked(_sender: UIButton){
   
  }
}
```

Before going to the ViewModel, we shall create our network Service, that will help us simulate the backend.

Swift File --- NetworService.swift 

```swift
import Foundation

final class NetworkService {
  static let shared = NetworkService() //singleton
  var user : User?
  private init() { }
  
  func login (email: String, password: String, completion @escaping(Bool) -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
      {[weak self] in} // to prevent any network leakages (Retain Cycles)
      
      if email == "test@test.com" && password == "password"{
        self?.user = User(firstname: "Shreya", lastname: "Holla", email: "test@test.com", age: 22)
        completion(true)
      }else 
        self?.user = nil
        completion(false)
      }
    }
  }
}
```



Now, in our LoginViewModel, we will be implementing the business logic

Unlike the MVC, we cannot directly update the view

```swift
import Foundation
final class LoginViewModel {
  
  //observable object of type optional string initialized to nil
  var error: ObservableObject<String?> = ObservableObject(nil)
  
  //Implementing Binding --- Observable
  //coming from our view
  func login(email: String, password: String){
    NetworkService.shared.login(email: email, password: password){[weak self] success in
      self?.error.value = success ? nil : "Invalid Credentials"
                                                               
    }
  }
}
```

Now, come back to the viewController...

```swift
import UIKit

class LoginViewController : UIViewController {
  
  private let viewModel = LoginViewModel()
  
  override func viewDidLoad(){
    super.viewDidLoad()
    setupBinders()
  }
  private func setupBinders() {
		viewModel.error.bind{ [weak self] error in
    	if let error = error {
        print(error)
      }else {
        self?.goToHomePage()
      }     
    }    
  }
  
  private func goToHomePage(){
    
    let vc = storyboard?.instanciateViewController(withIdentifier: "")as! HomePageVC
    
    present(vc, animated: false)
  }
  @IBAction func loginBtnClicked(_sender: UIButton){
   guard let email = emailField.text,
    		 let password = passwordField.text else {
           print("Please enter email and password")
           return
         }
    viewModel.login(email: email, password: password)
  }
}
```

Implement MVVM model for each and every view.

create a swift file... HomePageModel.swift

```swift
import Foundation

final class HomeViewModel {
  
  var welcomeMessage : ObservableObject<String?> = ObservableObject(nil)
  
  func getLoggedInUser(){
   
  }
}
```

Now go to network service and implement the loggedInUserMethod.

```swift
import Foundation

final class NetworkService {
  static let shared = NetworkService() //singleton
  var user : User?
  private init() { }
  
  func login (email: String, password: String, completion @escaping(Bool) -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
      {[weak self] in} // to prevent any network leakages (Retain Cycles)
      
      if email == "test@test.com" && password == "password"{
        self?.user = User(firstname: "Shreya", lastname: "Holla", email: "test@test.com", age: 22)
        completion(true)
      }else 
        self?.user = nil
        completion(false)
      }
    }
  }

func getLoggedInUser() -> User {
  
  return user!
	}
}
```

come back to homeViewModel

```swift
import Foundation

final class HomeViewModel {
  
  var welcomeMessage : ObservableObject<String?> = ObservableObject(nil)
  
  func getLoggedInUser(){
   
    let user = NetworkService.shared.getLoggedInUser()
    //the view is not aware of the userModel.
    self.welcomeMessage.value = "Hello, \(user.firstname) \(user.lastname)"
  }
}
```

go to HomePageVC

```swift
import UIKit
class HomeViewController: UIViewController {
  
  @IBOutlet weak var welcomeLbl : UILabel!
  
  private let viewModel = HomeViewModel()
  
  ovveride func viewDidLoad(){
    super.viewDidLoad()
    
    setupBinders()
    viewModel.getLoggedInUser()
    
  }
  
  private func setupBinders() {
    
    viewModel.welcomeMessage.bind { [weak self] message in
      self?.welcomeLbl.text = message
    }
  }
}

```

