//
//  PersistenceController.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin
import Combine

class PersistenceController: ObservableObject {
    @Published var userState : UserState = .loggedOut
    
    init() {
        if Amplify.Auth.getCurrentUser() != nil {
            self.userState = .signedIn
        }else {
            self.userState = .loggedOut
        }
    }
}
