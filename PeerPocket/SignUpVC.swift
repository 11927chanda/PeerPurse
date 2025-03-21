//
//  SignUpVC.swift
//  PeerPocket
//
//  Created by 11927 on 7/3/2025.
//

import UIKit
import FirebaseAuth


class SignUpVC: UIViewController {
    
    //all properties goes under here
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    var service = Repository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpDidPress(_ sender: UIButton) {
        
        guard !emailTextField.text.isBlank else {
            showAlertMessage(title: "Validation", message: "Email is mandatory")
            return
        }
        guard !passwordTextField.text.isBlank else {
            showAlertMessage(title: "Validation", message: "Password is mandatory")
            return
        }
        guard !passwordConfirmationTextField.text.isBlank else {
            showAlertMessage(title: "Validation", message: " Confirmed password is mandatory")
            return
        }
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmation = passwordConfirmationTextField.text,
              password == confirmation else{
            
            showAlertMessage(title: "Validation", message: "Passwords do not match")
            return
        }
        
        //all information is ready to be used
        
        //create a closure
       
        let registerClosure : ()->Void = {
            var userAuthId = Auth.auth().currentUser?.uid
            //block of code
            //register the user with its id in firebase
            let user = User(id: userAuthId,
                            firstname: "",
                            lastname: "",
                            email:email,
                            phone:"",
                            photo:"")
            
            //save
            if self.service.addUser(withData: user){
                print("User added: \(user.email)")
            }
            
            //removes signupVC from backstack making loginVC visible
            self.navigationController?.popViewController(animated: true)
        }
        
        Auth.auth().createUser(withEmail: email, password: password){
            authResult, error in guard error == nil else{
                self.showAlertMessage(title: "We could not create the account", message: "\(error!.localizedDescription)")
                return
            }
            print(authResult?.user.uid)
            /**
             Email confirmation
             */
            Auth.auth().currentUser?.sendEmailVerification{ error in
                if let error = error{
                    //there is an error
                    self.showAlertMessage(title: "Error", message: "\(error.localizedDescription)")
                    return
                }
                //there was no error
                //self.showAlertMessage(title: "Email Confirmation sent", message: "A confirmation email has been sent, plaese confirm before logging in.")
                
                //using show alert with handler
                self.showAlertMessageWithHandler(title: "Email Confirmation sent", message: "A confirmation email has been sent, plaese confirm before logging in.", onComplete: registerClosure)
                
            }
            
        }
        
        
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
