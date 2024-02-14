//
//  WelcomeView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/7.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        NavigationStack {
            ZStack {
                Color("color/background").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image(uiImage: #imageLiteral(resourceName: "welcome/onboard"))
                    Spacer()

                    Text("welcome.getStarted.title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("color/primary"))
                        .cornerRadius(50)

                    NavigationLink(
                        destination: LoginView()
                            .environmentObject(authService)
                            .navigationBarHidden(true),
                        label: {
                            Text("welcome.getStarted.signIn")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("color/primary"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                        .navigationBarHidden(true)

//                    HStack {
//                        Text("welcome.getStarted.isFirstTimeUse")
//                        Text("welcome.getStarted.createAccount")
//                            .foregroundColor(Color("color/primary"))
//                    }
                }
                .padding()
                .frame(maxWidth: 600)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
