//
//  AuthService.swift
//  DogGram
//

// Used to Authenticate users in Firebase
// Used to handle User accounts in Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore // Database

let DB_BASE = Firestore.firestore()

class AuthService {
    
    
    // MARK: PROPERTIES
    
    static let instance = AuthService()
    
    private var REF_USERS = DB_BASE.collection("users")
    
    
    // MARK: AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool, _ isNewUser: Bool?, _ userID: String?) -> ()) {
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            // Check for errors
            if error != nil {
                print("Error logging in to Firebase")
                handler(nil, true, nil, nil)
                return
            }
            
            // Check for provider ID
            guard let providerID = result?.user.uid else {
                print("Error getting provider ID")
                handler(nil, true, nil, nil)
                return
            }
            
            self.checkIfUserExistsInDatabase(providerID: providerID) { (returnedUserID) in
                
                if let userID = returnedUserID {
                    // User exists, log in to app immediately
                    handler(providerID, false, false, userID)
                    
                } else {
                    // User does NOT exist, continue to onboarding a new user
                    handler(providerID, false, true, nil)
                }
                
            }
                        
        }
        
    }
    func signUpWithEmail(name: String, email: String, password: String, profileImage: UIImage?, handler: @escaping (_ success: Bool, _ userID: String?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            // Check for errors
            if let error = error {
                print("Error creating new user in Firebase. \(error.localizedDescription)")
                handler(false, nil)
                return
            }
            
            // Get the user ID
            guard let userID = authResult?.user.uid else {
                print("Error getting user ID from Firebase")
                handler(false, nil)
                return
            }
            
            // Upload profile image to Storage
            if let image = profileImage {
                ImageManager.instance.uploadProfileImage(userID: userID, image: image)
            }
            
            // Upload profile data to Firestore
            let userData: [String: Any] = [
                DatabaseUserField.displayName : name,
                DatabaseUserField.email : email,
                DatabaseUserField.providerID : "",
                DatabaseUserField.provider : "",
                DatabaseUserField.userID : userID,
                DatabaseUserField.bio : "",
                DatabaseUserField.dateCreated : FieldValue.serverTimestamp(),
            ]
            
            REF_USERS.document(userID).setData(userData) { (error) in
                
                if let error = error {
                    //Error
                    print("Error uploading data to user document. \(error)")
                    handler(false, nil)
                } else {
                    //Success
                    handler(true, userID)
                }
                
            }
            
        }
        
    }



    
    func logInUserToApp(userID: String, handler: @escaping (_ success: Bool) -> ()) {
        
        // Get the users info
        getUserInfo(forUserID: userID) { (returnedName, returnedBio) in
            if let name = returnedName, let bio = returnedBio {
                // Success
                print("Success getting user info while logging in")
                handler(true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // Set the users info into our app
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.set(bio, forKey: CurrentUserDefaults.bio)
                    UserDefaults.standard.set(name, forKey: CurrentUserDefaults.displayName)
                }
                
                
            } else {
                // Error
                print("Error getting user info while logging in")
                handler(false)
            }
        }
        
        
    }
    
    func logOutUser(handler: @escaping (_ success: Bool) -> ()) {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error \(error)")
            handler(false)
            return
        }
        
        handler(true)
        
        // Updated UserDefaults
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
            defaultsDictionary.keys.forEach { (key) in
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping (_ userID: String?) -> ()) {
        
        // Set up a user Document with the user Collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload profile image to Storage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        // Upload profile data to Firestore
        let userData: [String: Any] = [
            DatabaseUserField.displayName : name,
            DatabaseUserField.email : email,
            DatabaseUserField.providerID : providerID,
            DatabaseUserField.provider : provider,
            DatabaseUserField.userID : userID,
            DatabaseUserField.bio : "",
            DatabaseUserField.dateCreated : FieldValue.serverTimestamp(),
        ]
        
        document.setData(userData) { (error) in
            
            if let error = error {
                //Error
                print("Error uploading data to user document. \(error)")
                handler(nil)
            } else {
                //Success
                handler(userID)
            }
            
        }
        
    }
    
    
    private func checkIfUserExistsInDatabase(providerID: String, handler: @escaping (_ existingUserID: String?) -> ()) {
        // If a userID is returned, then the user does exist in our database
        
        REF_USERS.whereField(DatabaseUserField.providerID, isEqualTo: providerID).getDocuments { (querySnapshot, error) in
            
            if let snapshot = querySnapshot, snapshot.count > 0, let document = snapshot.documents.first {
                //SUCCESS
                let existingUserID = document.documentID
                handler(existingUserID)
                return
            } else {
                // ERROR, NEW USER
                handler(nil)
                return
            }
            
        }
        
    }
    
    
    // MARK: GET USER FUNCTIONS
    
    func getUserInfo(forUserID userID: String, handler: @escaping (_ name: String?, _ bio: String?) -> ()) {
        
        REF_USERS.document(userID).getDocument { (documentSnapshot, error) in
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserField.displayName) as? String,
               let bio = document.get(DatabaseUserField.bio) as? String {
                print("Success getting user info")
                handler(name, bio)
                return
            } else {
                print("Error getting user info")
                handler(nil, nil)
                return
            }
        }
        
    }
    
    // MARK: UPDATE USER FUNCTIONS
    
    func updateUserDisplayName(userID: String, displayName: String, handler: @escaping (_ success: Bool) -> ()) {
        
        let data: [String:Any] = [
            DatabaseUserField.displayName : displayName
        ]
        
        REF_USERS.document(userID).updateData(data) { (error) in
            if let error = error {
                print("Error updating user display name. \(error)")
                handler(false)
                return
            } else {
                handler(true)
                return
            }
        }
        
    }
    
    func updateUserBio(userID: String, bio: String, handler: @escaping (_ success: Bool) -> ()) {
        
        let data: [String:Any] = [
            DatabaseUserField.bio : bio
        ]
        
        REF_USERS.document(userID).updateData(data) { (error) in
            if let error = error {
                print("Error updating user display name. \(error)")
                handler(false)
                return
            } else {
                handler(true)
                return
            }
        }
        
    }
    
    
    
}
