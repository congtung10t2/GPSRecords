//
//  MapViewController.swift
//  GPSTracker
//
//  Created by iMac on 2/21/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import Foundation
import MapKit
class MapViewController : UIViewController {
  @IBOutlet weak var dismissBtn: UIButton!
  @IBOutlet weak var uploadBtn: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    let overlays = mapView.overlays
    mapView.removeOverlays(overlays)
    mapView.delegate = self
    let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
      let first = CoreDataManager.shared.locationShowing.first
      let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: first!.lat, longitude: first!.lng), span: span)
      mapView.setRegion(region, animated: true)
      let polyline  = addPolyline()
    
      mapView.addOverlay(polyline)
    if CoreDataManager.shared.shouldShowUpload() {
      uploadBtn.isHidden = false
    } else {
      uploadBtn.isHidden = true
    }
  }
  @IBAction func onDismiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  func addPolyline() -> MKPolyline {
    var locations = CoreDataManager.shared.locationShowing.sorted {
      $0.timestamp < $1.timestamp
    }
    return MKPolyline(coordinates: locations.map({CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng)}), count: locations.count)
    
  }
  @IBAction func onUpload(_ sender: Any) {
    let tracker = Tracker(locations: CoreDataManager.shared.locationShowing)
    let loading = self.showLoading()
    tracker.uploadToCloud() { (data, error) in
     
      self.hideLoading(hud: loading)
      if let error = error {
        self.showAlert(title: "GPSTracker", message: "Tải lên thất bại")
      } else {
        self.uploadBtn.isHidden = true
        self.showAlert(title: "GPSTracker", message: "Tải lên thành công")
      }
    }
    
  }
}
extension MapViewController : MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer! {
    if(overlay is MKPolyline) {
      var pr = MKPolylineRenderer(overlay: overlay)
      pr.strokeColor = UIColor.red
      pr.lineWidth = 1
      return pr
    }
    return nil
  }
}
