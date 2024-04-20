//
//  ContentView.swift
//  Swift-UI-Dement
//
//  Created by Ajay Yadav on 4/15/24.
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

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    var body: some View {
        ZStack {
            Color.gray // Set the background color to gray
            
            TabView {
                // Home Tab
                VStack {
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
                    
                    
                    VStack{
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray, lineWidth: 2) // Adjust color and lineWidth as needed
                            .frame(width: 390, height: 180).overlay(
                                HStack{
                                    Text("Find People")
                                    Spacer()
                                }
                                
                            
                            )
                        
                    }.padding(.top,20)
                    
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
