//
//  TimelineView.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/16/24.
//

import SwiftUI

struct TimelineView: View {
    let hours: [String] = ["12 AM","1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]
    
    var body: some View {
        ZStack {
            TabView {
                VStack{
                    HStack{
                        Text("Good Afternoon").padding(30)
                        Spacer()
                    }
                    
                    ScrollView {
                        HStack {
                            VStack(spacing: 24) {
                                ForEach(hours, id: \.self) { hour in
                                    HStack {
                                        Text(hour)
                                            .font(Font.custom("Avenir", size: 9))
                                            .frame(width: 28, height: 20, alignment: .center)
                                        VStack {
                                            Divider()
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 16)
                    .background()
                    .ignoresSafeArea()
                    VStack {
                                GeometryReader { geometry in
                                    UnevenRoundedRectangle(
                                    topLeadingRadius: 40,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 40,
                                    style: .continuous
                                    ).stroke(Color.gray, lineWidth: 2)
                                        .frame(width: geometry.size.width / 100 * 100, height: 400).overlay(
                                            VStack(alignment: .leading) {
                                                Text("Prescription")
                                                    .font(.headline)
                                                    .padding(.leading)

                                                Text("Tap a medication to record a dose")
                                                    .font(.subheadline)
                                                    .padding([.leading, .bottom])
                                                Spacer()
                                                HStack(spacing: 10) { // Adjust spacing as needed
                                                                    RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 120, height: 120)
                                                                    RoundedRectangle(cornerRadius: 20).fill(Color.red).frame(width: 120, height: 120)
                                                                    RoundedRectangle(cornerRadius: 20).fill(Color.yellow).frame(width: 120, height: 120)
                                                                }
                                                                .padding(.horizontal, 20)
                                                                .padding(.bottom, 25)
                                            }.padding(.top,50)
                                        )
                                }
                        
                            }
                            .padding(.top, 0)
                            .frame(height: 270)
                        
                }.padding(.bottom,130)
                    
                
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
        Color.gray // Set the background color to gray
    }
    
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
