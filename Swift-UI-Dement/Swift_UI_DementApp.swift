//
//  Swift_UI_DementApp.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/16/24.
//

import SwiftUI
import Firebase

@main
struct Swift_UI_DementApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)         
        }
    }
}
