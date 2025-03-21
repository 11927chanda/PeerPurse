//
//  Repository.swift
//  PeerPocket
//
//  Created by 11927 on 14/3/2025.
//

import Foundation
import FirebaseFirestore

class Repository{
    var db = Firestore.firestore()
    
    func findUserContacts( fromCollection name : String, completion : @escaping([Contact]) -> () ){
        var contacts = [Contact]()
        db.collection(name)
            .addSnapshotListener{snapshot, error in
                if let document = snapshot?.documents{
                    //at this point we have documents
                    contacts = document.compactMap({ doc -> Contact? in
                    //the constant data is a dictionary with the values of document (contact)
                        let data = doc.data()
                        return Contact(id: doc.documentID, dictionary: data)
                    })
                    for contact in contacts {
                        print("XXXXXXXXXXXX")
                        print(contact.toString())
                    }
                    //we executed the completion which is a block of code received as param
                    completion(contacts)
                }else{
                    print("ERROR \(error!.localizedDescription)")
                    return
                }
            }
    }
    func addUser(withData user: User) -> Bool{
        var result = true
        let dictionary : [String : Any] = [
            "firstname": user.firstname as String,
            "lastname": user.lastname as String,
            "email": user.email as String,
            "phone": user.phone as String,
            "photo": user.photo as String,
            "registered": user.registered ?? FieldValue.serverTimestamp()
            
        ]
        db.collection("users").document(user.id).setData(dictionary) {error in
            if let error = error{
                print("user could not be added\(user.email), error: \(error.localizedDescription)")
                result = false
            }
        }
        
        return result
    }

}

