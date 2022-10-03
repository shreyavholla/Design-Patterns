# MVC - Model View Controller


![Alt text](/Design-Patterns/Screenshot 2022-10-03 at 2.45.45 PM.png)


- The model is usually a struct or a class. (user - model)
- The view is what you can see in your device (buttons, textfields, etc..)
- The controller controls the things in your app, and acts like a middleman between the model and the view.



- In UIKit the View & Controller is merged as ViewController. 
- Model - struct
  - create a new swift file
- Controller - ViewController
- View - Subclasses of UIView (Cocoa Touch Class)



- Disadvantage :
  - Becomes messy for larger objects.
  - So we use... MVVM design pattern.



