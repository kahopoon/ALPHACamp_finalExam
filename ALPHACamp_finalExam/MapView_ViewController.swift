//
//  MapView_ViewController.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit
import MapKit

class MapView_ViewController: UIViewController {

    @IBOutlet weak var mapViewFrame: MKMapView!
    var targetAddress:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // translate address into coordinate
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(targetAddress, completionHandler: {(placemarks, error) -> Void in
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                // put x,y to marker
                let annotation = MKPointAnnotation()
                annotation.title = self.targetAddress
                annotation.coordinate = coordinates
                // put marker into mapview
                self.mapViewFrame.addAnnotation(annotation)
                // zoom to target
                let region = MKCoordinateRegion(center:coordinates, span:MKCoordinateSpan(latitudeDelta: 0.005,longitudeDelta: 0.005))
                self.mapViewFrame.setRegion(region, animated:true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
