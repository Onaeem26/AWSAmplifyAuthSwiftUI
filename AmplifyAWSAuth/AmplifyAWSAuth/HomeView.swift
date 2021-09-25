//
//  HomeView.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    var body: some View {
        Text("Hello \(email)")
        Button {
            self.signOutLocally()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Sign Out")
        }.onAppear {
            fetchUserAttributes()
        }

    }
    
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    func fetchUserAttributes() {
        
        Amplify.Auth.fetchUserAttributes() { result in
                switch result {
                case .success(let attributes):
                    print("User attributes - \(attributes)")
                    for att in attributes {
                        if att.key == AuthUserAttributeKey.email {
                            self.email = att.value
                        }
                    }
                case .failure(let error):
                    print("Fetching user attributes failed with error \(error)")
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
