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
    static let shared = AuthService()
    @Published var status: AuthStatus = .notDetermined
    @Published var user: User = .init()
    
    init() {
//        Auth.auth().useEmulator(withHost: "192.168.1.163", port: 9099)
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.status = .login
                self.user = User(
                    userID: user?.uid ?? "fakeUserID",
                    email: user?.email ?? "fake@seaotter.cc",
                    name: user?.displayName ?? "使用者名稱為空",
                    profileImageUrl: user?.photoURL,
                    position: "老闆",
                    imageName: "person.circle"
                )
                print("Auth state changed, is signed in")
                print(user ?? "")
            } else {
                self.status = .logout
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
        guard let rootViewController = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last?.rootViewController else {
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
    
    enum AuthStatus {
        case login
        case logout
        case notDetermined
    }
}
