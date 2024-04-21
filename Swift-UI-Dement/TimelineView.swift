//
//  TimelineView.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/16/24.
//

import SwiftUI

struct CheckBoxItem {
    var name: String
    var isChecked: Bool
}

struct CheckBoxView: View {
    @Binding var item: CheckBoxItem
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isChecked ?.green : .gray)
                .font(.system(size: 22))
        }
    }
}

struct MedicationCard: View {
    let name: String
    let dose: String
    
    init(name: String, dose: String) {
        self.name = name
        self.dose = dose
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 120, height: 120)
            Text(name)
            Text(dose)
        }
    }
}

struct MedicationGrid: View {
    var body: some View {
        HStack(spacing: 10) {
            MedicationCard(name: "Aspirin", dose: "10 mg")
            MedicationCard(name: "Aspirin", dose: "10 mg")
            MedicationCard(name: "Aspirin", dose: "10 mg")
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 25)
    }
}


struct PrescriptionHeader: View {
    var addAction: () -> Void // Action to add a new medication
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Prescription")
                    .font(.headline)
                    .padding(.leading)

                Text("Tap a medication to record a dose")
                    .font(.subheadline)
                    .padding([.leading, .bottom])
            }
            Spacer()
            Button(action: addAction) {
                Image(systemName: "plus")
                    .padding(8)
                    .background(Circle().fill(Color.white).frame(width: 30, height: 30))
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .padding()
        }
    }
}

// Timeline View
struct TimelineScrollView: View {
    let hours: [String]
    
    init(hours: [String]) {
        self.hours = hours
    }
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(spacing: 24) {
                    ForEach(hours, id: \.self) { hour in
                        HStack {
                            Text(hour)
                                .font(Font.custom("Avenir", size: 9))
                                .frame(width: 28, height: 20, alignment: .center)
                            VStack {
                                Divider().overlay(VStack{
                                    Text("hello")
                                })
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.top, -10)
        .padding(.bottom, 10)
        .padding(.horizontal, 16)
    }
}

struct MedicationView: View {
    @ObservedObject private var medicineView = MedicineViewModel()
    
    var body: some View {
        NavigationView {
            List($medicineView.medicines) { $medicine in
                HStack{
                    MedicationItem(
                    medicationName: medicine.name,
                    description: String(format: "%.2f mg", medicine.dose)
                )
                    Image(systemName: MedicationItem(isSelected: Bool) ? "checkmark.square" : "square")
                }
            }
            .navigationTitle("Edit Prescription")
            .navigationBarItems(trailing: Button("Done") {
                // Perform an action when Done is tapped
            })
            .background(
                UnevenRoundedRectangleForMedication()
                    .fill(Color.white)
                    .frame(height: 300)
                    .edgesIgnoringSafeArea(.top)
            ).onAppear(){
                self.medicineView.fetchMedicines()
            }
        }
    }
}

struct MedicationItem: View {
    var medicationName: String // This will store the medication name
    var description: String   // This will store the description or additional text
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color.gray, lineWidth: 1)
                .frame(width: 60, height: 60)
                .padding(.leading, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(medicationName)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(height: 100)
        .padding(.trailing, 16)
    }
}


// Custom shape with uneven rounded corners
struct UnevenRoundedRectangleForMedication: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define points for the custom shape
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: topLeft)
        
        // Top left corner - uneven curve
        path.addLine(to: CGPoint(x: rect.minX + 30, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + 30),
                      control1: CGPoint(x: rect.minX + 15, y: rect.minY),
                      control2: CGPoint(x: rect.minX, y: rect.minY + 15))
        
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        
        // Top right corner - straight line
        path.addLine(to: topRight)
        
        // Connect back to start point
        path.addLine(to: topLeft)
        
        return path
    }
}


struct TimelineView: View {
    @State private var isAddingMedication = false
    
    let hours: [String] = ["12 AM","1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]
    
    var body: some View {
        ZStack {
                VStack{
                    HStack{
                        Text("Good Afternoon")
                            .font(.title) // or any other desired font modifier
                            .padding(.top, 20)
                            .padding(.leading, 20)
                            .padding(.bottom, 20)

                        Spacer()
                    }
                    
                    TimelineScrollView(hours: hours)
                    VStack {
                        GeometryReader { geometry in
                            UnevenRoundedRectangle(
                                topLeadingRadius: 40,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 40,
                                style: .continuous
                            )
                            .stroke(Color.clear, lineWidth: 0)
                            .shadow(color: Color.gray, radius: 100, x: 10, y: 10)
                            .frame(width: geometry.size.width / 100 * 100, height: 320)
                            .overlay(
                                VStack(alignment: .leading) {
                                    PrescriptionHeader {
                                        self.isAddingMedication.toggle()
                                    }
                                    Spacer()
                                    MedicationGrid()
                                }
                                .padding(.top, 50)
                            )
                        }
                    }
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .frame(height: 270)
                        
                }.padding(.bottom,50)
                    
        }.sheet(isPresented: $isAddingMedication){
            MedicationView()
        }
        Color.gray // Set the background color to gray
    }
}


struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
