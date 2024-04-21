//
//  AuthViewModel.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: Manager?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            print("DEBUG: Failed to login in user with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let manager = Manager(id: result.user.uid, fullname: fullname, email: email, password: password, patients: nil, prescriptions: nil)
            let encodedUser = try Firestore.Encoder().encode(manager)
            try await Firestore.firestore().collection("Managers").document(manager.id).setData(encodedUser)
            await fetchUser()
        }
        catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut()
    {
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("Managers").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: Manager.self)
        
        print("DEBUG: current user is \(self.currentUser)")
    }
    
    
}
