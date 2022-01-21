//
//  ViewController.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit
import MapKit


class DetailViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mkMapView: MKMapView!


    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantCategory: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantPhone: UILabel!
    @IBOutlet weak var restaurantSocialHandler: UILabel!
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    var restaurant: Restaurant?
    private var isMapExtended: Bool = false
    var location: CLLocation = CLLocation();
    
    
    @IBAction func showFullMap(_ sender: UIBarButtonItem) {
        expandMap(!isMapExtended)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zoomMap(location)
        
    }


    private func updateViews() {
        restaurantPhone.text = ""
        restaurantSocialHandler.text = ""
        guard let restaurant = restaurant else { return }
        restaurantName.text = restaurant.name
        restaurantCategory.text = restaurant.category
        restaurantAddress.text = restaurant.location.formattedAddress[0]
       + " " + restaurant.location.formattedAddress[1]
        guard let contact = restaurant.contact else { return }
        restaurantPhone.text = contact.formattedPhone
        
        if let facebookName = contact.facebookName {
            restaurantSocialHandler.text = "@\(facebookName)"
        }
        
        if let twitter = contact.twitter {
            restaurantSocialHandler.text = "@\(twitter)"
        }
    }
        
        
        private func setupMapView() {
                mkMapView.delegate = self
                guard let lat = restaurant?.location.lat, let long = restaurant?.location.lng else { return }
                location = CLLocation(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                mkMapView.addAnnotation(annotation)
            }
            
            private func zoomMap(_ location: CLLocation) {
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion (center: location.coordinate, span: span)
                mkMapView.setRegion(mkMapView.regionThatFits(region), animated: true)
            }
            
            private func expandMap(_ expand: Bool) {
                isMapExtended = expand
                UIView.animate(withDuration: 0.5) {
                    self.mapViewHeightConstraint.priority = UILayoutPriority(expand ? 500 : 1000)
                    self.view.layoutIfNeeded()
                }
            }
            
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                let reuseIdentifier = "annotationView"
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                view.displayPriority = .required
                view.image = UIImage(named: AssetConstants.mapPointer)
                view.annotation = annotation
                return view
    }
}
