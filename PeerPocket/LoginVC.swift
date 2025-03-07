//
//  LoginVC.swift
//  PeerPocket
//
//  Created by 11927 on 7/3/2025.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //all properties goes under here
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func forgottenPasswordDidPress(_ sender: UIButton) {
        //TODO after we manage to do signup
    }
    
    @IBAction func loginDidPress(_ sender: UIButton) {
        guard !emailTextField.text.isBlank else{
            //show an alert to user
            showAlertMessage(title: "Validation", message: "Email is mandatory")
            
            return
        }
            
            guard emailTextField.text.isValidEmail else {
                showAlertMessage(title: "Validation", message: "Invalid Email format")
                
                return
            }
            
        guard !passwordTextField.text.isBlank else{
            showAlertMessage(title: "Validation", message: "Password is mandatory")
            return
        }
        
        //we have to use firebase Auth to login
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            //completion block
            guard error == nil else{
                self.showAlertMessage(title: "Failed to login", message: "\(error!.localizedDescription)")
                return
            }
            //verify email cinfirmation
            guard let authUser = Auth.auth().currentUser, authUser.isEmailVerified else {
                self.showAlertMessage(title: "Pending email verification", message: "Please verify your email")
                return
            }
            //programmatically navigate to HomeVC
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as?
                        UITabBarController
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
             
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
