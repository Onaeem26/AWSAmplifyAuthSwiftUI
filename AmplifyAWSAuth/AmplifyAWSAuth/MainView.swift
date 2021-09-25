//
//  MainView.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI

enum UserState {
    case signedIn
    case loggedOut
    case sessionExpired
}

struct MainView: View {
    @StateObject var persistenceController = PersistenceController()
    @State var presentHomeView: Bool = true
    var body: some View {
        switch(self.persistenceController.userState){
        case .signedIn:
            ContentView()
                .fullScreenCover(isPresented: self.$presentHomeView) {
                    HomeView()
                }
        case .loggedOut:
            ContentView()
        case .sessionExpired:
            ContentView()
        }
        
    }
}

