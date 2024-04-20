//
//  PrescriptionView.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/16/24.
//

import SwiftUI

struct PrescriptionView: View {
    var body: some View {
        VStack {
            // Greeting text
            Text("Good Afternoon")
                .font(.largeTitle)
                .padding()

            Spacer() // This will push all content to the top

            // Prescription section
            VStack(alignment: .leading) {
                Text("Prescription")
                    .font(.headline)
                    .padding(.leading)

                Text("Tap a medication to record a dose")
                    .font(.subheadline)
                    .padding([.leading, .bottom])

                // Medication squares
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .aspectRatio(1, contentMode: .fit)
                            .padding()
                    }
                }

                // Add button
                HStack {
                    Spacer()
                    Button(action: {
                        // Action to add a new medication
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Circle().fill(Color.white))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding()
                }
            }

            Spacer() // This will push the content above to the top and below content to the bottom
        }
        .padding(.top, 1) // Slight padding from the top of the view
    }
}

struct PrescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PrescriptionView()
    }
}
