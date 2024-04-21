//
//  Patients.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

import Foundation

struct Patients: Identifiable, Codable {
    
    let id: String
    let fullname: String
    let email: String
    var prescriptions: [Prescriptions]? // Changed to an array of Prescription
    
}
