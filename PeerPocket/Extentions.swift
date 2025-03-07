//
//  Extentions.swift
//  PeerPocket
//
//  Created by 11927 on 7/3/2025.
//

import Foundation
import UIKit

//create an extention for String
extension Optional where Wrapped == String {
    
    var isBlank: Bool {
        // if we managed to unwrap it then its not nil, else is nil
        guard let notNilBool = self else {
            return true
        }
        
        //at this point notNilBool is not nil, so we can trim the space and check if it's empty
        return notNilBool.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
extension Optional where Wrapped  == String {
    var isValidEmail: Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
extension String {
    var isBlank : Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension UIViewController{
    func showAlertMessage(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
}
