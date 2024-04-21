//
//  PatientForm.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/18/24.
//
import SwiftUI

struct PatientForm: View {
    @State private var name: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var email: String = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Good morning,\nDaffa Toldo!")
                .font(.title)
                .fontWeight(.light)
                .padding()

            VStack {
                Text("Add Patient")
                    .font(.headline)
                    .padding(.bottom, 20)

                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)

                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                HStack(spacing: 10) {
                    Button("Add") {
                        // Handle add action
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(5.0)

                    Button("Cancel") {
                        // Handle cancel action
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PatientForm()
}
