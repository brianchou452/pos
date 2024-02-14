//
//  LoginView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/6.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color("color/background").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Text("Login.Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    Button {
                        authService.signInWithGoogle()
                    } label: {
                        SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "welcome/google")), text: Text("Login.LoginWithGoogle").foregroundColor(Color("color/primary")))
                            .padding(.vertical)
                    }
                    
                    Text("Login.useEmailAndPassword")
                        .foregroundColor(Color.black.opacity(0.4))
                    
                    TextField("Login.emailField.Title", text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Login.PasswordField.Title", text: $password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                    
                    Button {
                        authService.signInWithEmail(email: email, password: password)
                    } label: {
                        PrimaryButton(title: Text("Login.Title"))
                    }
                }
                
                Spacer()
                Divider()
                Spacer()
                Text("You are completely safe.")
                Text("Read our Terms & Conditions.")
                    .foregroundColor(Color("color/primary"))
            }
            .padding()
            .frame(maxWidth: 600)
        }
    }
}

struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        ZStack {
            HStack {
                image
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Spacer()
                text
                    .font(.title2)
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}

struct PrimaryButton: View {
    var title: Text
    var body: some View {
        title
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("color/primary"))
            .cornerRadius(50)
    }
}

#Preview {
    LoginView()
}
