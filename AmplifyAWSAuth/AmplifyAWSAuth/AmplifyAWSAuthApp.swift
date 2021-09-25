//
//  AmplifyAWSAuthApp.swift
//  AmplifyAWSAuth
//
//  Created by Muhammad Osama Naeem on 9/22/21.
//

import SwiftUI

@main
struct AmplifyAWSAuthApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
