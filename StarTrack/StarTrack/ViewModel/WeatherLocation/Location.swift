//
//  File.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/17/25.
//

import Foundation
import CoreLocation

class LocalManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else{ return}
        location = newLocation
    }
}
