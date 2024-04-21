//
//  DataManager.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

//import SwiftUI
//import Firebase
//
//class DataManager: ObservableObject {
//    @Published var medicines: [Medicines] = []
//    
//    func fetchMedicines(){
//        medicines.removeAll()
//        let db = Firestore.firestore()
//        let ref = db.collection("Medicines")
//        ref.getDocuments{ snapshot, error in
//            guard error == nil else{
//                print(error!.localizedDescription)
//                return
//            }
//            
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//                    
//                    let id = data["ID"] as? String ?? ""
//                    let dose = data["Dose"] as? Float ?? 0.0
//                    let name = data["Name"] as? String ?? "dfgfd"
//                    let time = data["Time"] as? String ?? ""
//                    
//                    let medicine = Medicines(dose: dose, id: id, name: name, time: time)
//                    self.medicines.append(medicine)
//
//                }
//            }
//        }
//    }
//}

