////
////  ListView.swift
////  Swift-UI-Dement
////
////  Created by Vasav Srivastava on 4/20/24.
////
//
//import SwiftUI
//
//struct ListView: View {
//    @EnvironmentObject var dataManager: DataManager
//    
//    var body: some View {
//        NavigationView {
//            List(dataManager.medicines, id: \.id) { medicine in
//                Text(medicine.name)
//            }
//            .navigationTitle("Medicines")
//            .navigationBarItems(trailing: Button(action: {
//                // add action
//            }, label: {
//                Image(systemName: "plus")
//            }))
//        }
//    }
//}
//
//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView().environmentObject(DataManager())
//    }
//}
//
