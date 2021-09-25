//
//  RegisterView.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import Combine

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showConfirmationCodeView: Bool = false
    @State var userModel = UserDataModel()
    
    var body: some View {
        ZStack {
            Color.init(UIColor.systemBackground)
            VStack {
                
                HStack {
                    Text("Existing User? /")
                        .foregroundColor(Color.secondary)
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Log In")
                            .bold()
                    })
                        
                    Spacer()
                }.padding(.horizontal)
                    .padding(.top, 20)
                
                TextField("Email", text: $userModel.email)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                SecureField("Password", text: $userModel.password)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                TextField("Username", text: $userModel.username)
                    .padding(20)
                    .foregroundColor(Color.primary)
                    .background(Color("TextfieldBg"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                Button {
                    self.signUp(username: userModel.username, password: userModel.password, email: userModel.email) { state in
                        if state == true {
                            print("Halo this is successful")
                            showConfirmationCodeView = true
                        }
                    }
                    
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
                
                NavigationLink(destination: ConfirmationCodeView(userModel: self.userModel), isActive: $showConfirmationCodeView) { EmptyView() }
                Spacer()
            }
        }
        .navigationTitle(Text("Register"))
    }
    
    func signUp(username: String, password: String, email: String, completion: @escaping (Bool) -> ()) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    completion(true)
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
