//
//  ConfirmationCodeView.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI
import Combine
import Amplify
import AWSCognitoAuthPlugin

struct ConfirmationCodeView: View {
    @State var confirmationCode: String = ""
    @State var showHomeView : Bool = false
    var userModel : UserDataModel
    
    var body: some View {
        ZStack {
            Color.init(UIColor.systemBackground)
            VStack {
                
                HStack {
                    Text("Please enter the confirmation code sent to your email address")
                        .foregroundColor(Color.secondary)
                    
                    Spacer()
                }.padding(.horizontal)
                    .padding(.top, 20)
                TextField("Enter Confirmation Code", text: $confirmationCode)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 30)

                Button {
                    self.confirmSignUp(for: self.userModel.username, with: self.confirmationCode)
                } label: {
                    Text("Sign Up")
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
        }
        .navigationTitle(Text("Confirm"))
        .fullScreenCover(isPresented: self.$showHomeView) {
            HomeView()
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                self.signIn(username: self.userModel.username, password: self.userModel.password)
                //self.showHomeView = true
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
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

