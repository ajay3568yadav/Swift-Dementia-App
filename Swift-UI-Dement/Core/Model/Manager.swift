//
//  Manager.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

import Foundation

struct Manager: Identifiable, Codable {
    
    let id: String
    let fullname: String
    let email: String
    let password: String
    let patients: [Patients]?
    var prescriptions: [Prescriptions]? // Changed to an array of Prescription
    
}
