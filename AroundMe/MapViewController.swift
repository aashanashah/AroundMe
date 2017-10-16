//
//  MapViewController.swift
//  AroundMe
//
//  Created by Aashana on 10/12/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var latitude:Double?
    var longitude:Double?
    var name:String?
    
    @IBOutlet var MapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        MapView.mapType = MKMapType.standard
        let location = CLLocationCoordinate2D(latitude: latitude!,longitude: longitude!)
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        MapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name!
        MapView.addAnnotation(annotation)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let currannotation = MKPointAnnotation()
        currannotation.coordinate = appDelegate.globalValue
        currannotation.title = "Your location"
        MapView.addAnnotation(currannotation)
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        if ((annotationView.annotation?.title)! == "Your location")
        {
            annotationView.pinTintColor = UIColor.blue
        
        }
        return annotationView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
