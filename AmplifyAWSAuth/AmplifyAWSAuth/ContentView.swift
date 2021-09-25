//
//  ContentView.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import Combine

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var showHomeView: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
            Color.init(UIColor.systemBackground)
            VStack {
                HStack {
                    Text("Hey, \nLogin Now.")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    
                }.padding(.horizontal)
                    .padding(.top, 80)
                
                HStack {
                    Text("If you are new /")
                        .foregroundColor(Color.secondary)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Create Account")
                            .bold()
                    }
                    
                    Spacer()
                }.padding(.horizontal)
                    .padding(.top, 20)
                    
                TextField("Username", text: $username)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 30)
                
                SecureField("Password", text: $password)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                Button {
                    self.signIn(username: self.username, password: self.password)
                } label: {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity , maxHeight: 40, alignment: .center)
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.init(UIColor(red: 0.90, green: 0.28, blue: 0.28, alpha: 1.00)))
                        .cornerRadius(10)
                        .padding(.top, 20)
                        
                }.padding(.horizontal)
                    
                
                Spacer()
            }
        }.ignoresSafeArea()
                .fullScreenCover(isPresented: self.$showHomeView) {
                    HomeView()
                }
        }
    }

    func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
                self.showHomeView = true
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
