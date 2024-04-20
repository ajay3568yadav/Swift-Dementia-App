//
//  BillView.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/16/24.
//

import SwiftUI

// Model for representing a bill
struct Bill: Identifiable {
    var id = UUID()
    var amount: Double
    var dueDate: String
}

// Custom row view for a bill
struct BillRow: View {
    let bill: Bill
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("$\(bill.amount, specifier: "%.2f")")
                    .font(.title2)
                Text("Due \(bill.dueDate)")
                    .font(.subheadline)
            }
            Spacer()
            // Placeholder for selection indicator
            Circle()
                .strokeBorder(Color.gray, lineWidth: 2)
                .frame(width: 30, height: 30)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
    }
}

// Main view
struct BillView: View {
    // Sample data for bills
    let upcomingBills: [Bill] = [
        Bill(amount: 115, dueDate: "20th Nov"),
        Bill(amount: 54, dueDate: "24th Dec"),
        Bill(amount: 45.04, dueDate: "26th Dec")
    ]
    
    var body: some View {
        ZStack {
            Color.gray // Set the background color to gray
            
            TabView {
                VStack {
                    Text("Bill Pay")
                        .font(.largeTitle)
                        .padding()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(upcomingBills) { bill in
                                BillRow(bill: bill)
                            }
                        }
                        .padding()
                        
                        Text("Subscriptions")
                            .font(.title)
                            .padding()
                        
                        // Placeholder for subscriptions list
                        // This can be replaced with a similar structure to the bills list
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray, lineWidth: 1)
                            .frame(height: 100)
                            .padding()
                    }
                }
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

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillView()
    }
}

