//
//  AuthService.swift
//  pos
//
//  Created by Brian Chou on 2024/2/13.
//

import FirebaseAuth
import FirebaseCore
import Foundation
import GoogleSignIn

class AuthService: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    init() {
        Auth.auth().useEmulator(withHost:"192.168.1.70", port:9099)
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.isSignedIn = true
                print("Auth state changed, is signed in")
                print(user ?? "")
            } else {
                self.isSignedIn = false
                print("Auth state changed, is signed out")
            }
        }
    }
    
    // Regular password acount sign out.
    // Closure has whether sign out was successful or not
    func signOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(signOutError)
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                print("Auth:")
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                print(authResult ?? "")
            }
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        // TODO: fix 'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("There is no root view controller!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            guard error == nil else {
                print("Error! \(String(describing: error))")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    print("Error! \(String(describing: error))")
                    return
                }
                print("google sign in success \(String(describing: result))")
                // At this point, our user is signed in
            }
        }
    }
}
