//
//  MapView.swift
//  Swift-UI-Dement
//
//  Created by Ajay Yadav on 4/16/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .cornerRadius(18)
            .frame(width: 180, height: 180)
    }
}
