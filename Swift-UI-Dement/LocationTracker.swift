//
//  ViewController.swift
//  Navigation
//
//  Created by Kritee Kondapally on 4/20/24.
//

import UIKit

import SwiftUI
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

struct MapView: UIViewRepresentable {
    var mapView: NavigationMapView!
    var locationManager = NavigationLocationManager()

    func makeUIView(context: Context) -> NavigationMapView {
        let mapView = NavigationMapView(frame: .zero)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = context.coordinator

        locationManager.delegate = mapView
        locationManager.startUpdatingLocation()

        guard let location = locationManager.location?.coordinate else {
            print("User location not available")
            return mapView
        }

        let origin = Waypoint(coordinate: location, name: "Start")
        print("origin: \(origin)")
        let destination = Waypoint(coordinate: LocationCoordinate2D(latitude: 36.9741, longitude: 122.0308), name: "Santa Cruz")
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])

        Directions.shared.calculate(routeOptions) { session, result in
        switch result {
                case .failure(let error):
                    print("Route calculation error: \(error)")
                case .success(let response):
                    guard let routes = response.routes, !routes.isEmpty else {
                        print("No routes found")
                        return
                    }
                self.mapView.showcase(routes)

                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
            }
        }

        return mapView
    }

    func updateUIView(_ uiView: NavigationMapView, context: Context) {
        // Update the view if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NavigationMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Implement delegate methods if needed
    }
}
