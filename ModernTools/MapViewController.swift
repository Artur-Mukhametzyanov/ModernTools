//
//  MapViewController.swift
//  ModernTools
//
//  Created by Artur Mukhametzyanov on 19.10.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {

    var locationManager: CLLocationManager?
    let coordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var markersArray = [GMSMarker]()
    
    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func followLocation(_ sender: Any) {
        locationManager?.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if markersArray.count == 0 {
            let camera = GMSCameraPosition.camera(withTarget: locations.first?.coordinate ?? coordinates, zoom: 17)
            let marker = GMSMarker(position: locations.first?.coordinate ?? coordinates)
            marker.map = mapView
            mapView.camera = camera
            markersArray.append(marker)
            locationManager?.stopUpdatingLocation()
        } else {
            let camera = GMSCameraPosition.camera(withTarget: locations.first?.coordinate ?? coordinates, zoom: 17)
            let marker = GMSMarker(position: locations.first?.coordinate ?? coordinates)
            marker.map = mapView
            mapView.camera = camera
            markersArray.append(marker)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
}
