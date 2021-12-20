//
//  ViewController4.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit
import MapKit

class MapRestaurants: UIViewController, MKMapViewDelegate, UIViewControllerTransitioningDelegate {

  
    @IBOutlet weak var mapView: MKMapView!
    var restaurants: [Restaurant]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(white: 0, alpha: 0)
        transitioningDelegate = self
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(zoomMap), with: nil, afterDelay: animationDuration)
    }
    
 
    private func setupMapView() {
        mapView.delegate = self
        guard let restaurants = restaurants else { return }
        restaurants.forEach { restaurant in
            createAnnotation(restaurant)
        }
    }
    
    private func createAnnotation(_ restaurant: Restaurant) {
        let lat = restaurant.location.lat
        let lng = restaurant.location.lng
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        annotation.title = restaurant.name
        annotation.subtitle = restaurant.location.address
        mapView.addAnnotation(annotation)
    }
    
    
    @objc private func zoomMap() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "annotationView"
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        view.displayPriority = .required
        view.image = UIImage(named: AssetConstants.mapPointer)
        view.annotation = annotation
        view.canShowCallout = true
        return view
    }
    
    
    @IBAction func closeMapView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

