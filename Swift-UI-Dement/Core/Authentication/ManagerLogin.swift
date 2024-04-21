// ContentView.swift
// Swift-UI-Dement
//
// Created by Ajay Yadav on 4/15/24.
//
import SwiftUI
import MapKit
struct ChatbotButton: View {
  var body: some View {
    Button(action: {
      // Action when chatbot button is tapped
      print("Chatbot button tapped!")
    }) {
      Image(systemName: "message.circle.fill")
        .font(.system(size: 40))
        .foregroundColor(.blue)
        .padding()
    }
  }
}
struct NameCardsView: View {
  var name: String
  var body: some View {
                VStack{
                Circle()
                  .stroke(Color.gray, lineWidth: 2)
                  .frame(width: 66, height: 66) // Adjust size as needed
                Text(name)
                  .fontWeight(.light)
                  .foregroundColor(.black)
              }
  }
}
struct FindPeopleView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  @State private var isActive = false // State to control navigation
  var body: some View {
      VStack(alignment: .leading){
        Text("Find People")
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 20)
        HStack(spacing: 29) {
          ForEach(0..<4, id: \.self) { index in
            //
          }
          NavigationLink(destination: PatientForm().environmentObject(viewModel), isActive: $isActive) {
          VStack(alignment: .center){
              Button(action: {
                self.isActive = true
              }) {
                Circle()
                  .stroke(Color.gray, lineWidth: 2)
                  .frame(width: 66, height: 66)
                  .overlay(
                    Text("+")
                      .font(.system(size: 24)) //
                      .foregroundColor(.gray) //
                  )
              }
              .padding(.top, 10)
            Text("Add Patient")
              .fontWeight(.light)
              .foregroundColor(.black)
          }.padding(.leading,25)
          }
        }
      }
    }
  }
struct ManagerLogin: View {
  @EnvironmentObject var viewModel: AuthViewModel
  @EnvironmentObject var medicineView: MedicineViewModel
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  var body: some View {
    if let user = viewModel.currentUser{
      NavigationView(){
        ZStack {
          Color.gray // Set the background color to gray
          TabView {
            // Home Tab
            VStack {
              HStack {
                Circle()
                  .stroke(Color.gray, lineWidth: 2)
                  .frame(width: 69, height: 69) // Adjust size as needed
                VStack(alignment: .leading) {
                  Text("Good morning,")
                    .font(.system(size: 13))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                  Text("Hello")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                Spacer()
                Circle()
                  .stroke(Color.gray, lineWidth: 2)
                  .frame(width: 40, height: 40) // Adjust size as needed
              }
              .padding(.horizontal, 5)
              .frame(height: 100)
              RoundedRectangle(cornerRadius: 30) // Adjust cornerRadius as needed
                .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                .frame(width: 390, height: 212)
                .overlay(
                  HStack {
                    RoundedRectangle(cornerRadius: 20)
                      .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                      .frame(width: 180, height: 180).overlay(
                        Map(coordinateRegion: $region)
                          .cornerRadius(18)
                          .frame(width: 180, height: 180)
                      ).padding(.leading,15)
                    VStack(alignment: .leading){
                      Text("Find Way Back").padding(.top,17).padding(.leading,22).fontWeight(.bold).font(.system(size: 20, weight: .regular, design: .default))
                      Text("16th April 2024").font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundStyle(.gray).padding(.top, 1).padding(.leading, 22)
                      Spacer()
                      Button(action: {
                        // Action when button is tapped
                        print("Button tapped!")
                      }) {
                        Text("Start")
                          .font(.headline)
                          .foregroundColor(.white)
                          .padding(5)
                          .frame(minWidth: 0, maxWidth: .infinity)
                          .background(Color.black)
                          .cornerRadius(100)
                          .padding(.horizontal)
                      }
                    }.padding(.bottom,15)
                  }
                )
    // Find People View
              VStack{
                RoundedRectangle(cornerRadius: 30)
                  .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                  .frame(width: 390, height: 165)
                  .overlay(
                    FindPeopleView().environmentObject(viewModel)
                  )
                  .padding(.top, 25)
              }
              Spacer()
              VStack{
                RoundedRectangle(cornerRadius: 30)
                  .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                  .frame(width: 390, height: 181)
                  .overlay(
                    VStack {
                      Text("Upcoming Activities")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                      HStack(spacing: 22) {
                        ForEach(0..<3, id: \.self) { _ in
                          RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                            .frame(width: 100, height: 100)
                        }
                      }
                      .frame(maxWidth: .infinity) // This ensures the HStack is centered in the overlay
                      .padding(.top, 10) // Add padding on top as needed
                    }
                  )
                  .padding(.top, 25)
              }
              Spacer()
              ChatbotButton()
            }
            .padding()
            .tabItem {
              Label("Home", systemImage: "house")
            }
            .tag(0)
            // Settings Tab
            Text("Settings")
              .tabItem {
                Label("Settings", systemImage: "gear")
              }
              .tag(1)
            // Community Tab
            Text("Community")
              .tabItem {
                Label("Community", systemImage: "person.3")
              }
              .tag(2)
            TimelineView()
              .tabItem {
                Label("Prescriptions", systemImage: "pills")
              }
              .tag(3)
            VStack {
              Text("Settings")
              Button("Sign Out") {
                viewModel.signOut() // Call sign-out function from your view model
              }
              .foregroundColor(.red)
              .padding()
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.red, lineWidth: 2)
              )
            }
            .tabItem {
              Label("Settings", systemImage: "gear")
            }
            .tag(4)
          }
        }
      }
    }
  }
}
struct ManagerLogin_Previews: PreviewProvider {
  static var previews: some View {
    ManagerLogin().environmentObject(AuthViewModel())
  }
}

