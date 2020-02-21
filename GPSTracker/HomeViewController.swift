//
//  HomeViewController.swift
//  GPSTracker
//
//  Created by iMac on 2/20/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  private var locationName: String = ""
  private var isUpdatingLocation: Bool = false
  private var dataSaved: Bool = true
  private var dataCancelled: Bool = false
  private var showingData: Bool = false
  private var hasRecorded: Bool = false
  @IBOutlet weak var playBtn: UIButton!
  @IBOutlet weak var saveAsBtn: UIButton!
  @IBOutlet weak var showDataBtn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  @IBAction func onPlay(_ sender: Any) {
    if(isUpdatingLocation) {
      LocationManager.shared.stopLocation()
    }
    self.isUpdatingLocation = true
    self.dataCancelled = false
    self.dataSaved = false
    self.hasRecorded = true
    
    LocationManager.shared.requestForLocation()
    LocationManager.shared.updatingLocation()
    CoreDataManager.shared.locationAdded = []
    updateState()
  }
  @IBAction func onSaveAs(_ sender: Any) {
    self.isUpdatingLocation = false
    LocationManager.shared.stopLocation()
    let alert = showAlertWithInput(title: "Gps tracker", message: "Lưu dữ liệu gpx")
    alert.addAction(UIAlertAction(title: "Đồng ý", style: .default) {  [unowned alert] _ in
      let answer = alert.textFields![0]
      if let text = answer.text {
        
        CoreDataManager.shared.save(name: text)
        self.dataSaved = true
      }
      self.dismiss(animated: true)
      self.updateState()
      
    })
    
    updateState()
  }
  @IBAction func onShowData(_ sender: Any) {
    CoreDataManager.shared.fromCloudTab = false
   self.showingData = true
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
    present(controller, animated: true, completion: nil)
    updateState()
  }
  
  func updateState() {
    playBtn.setVisible(visible: !isUpdatingLocation)
    saveAsBtn.setVisible(visible: isUpdatingLocation && !dataSaved)
    showDataBtn.setVisible(visible: dataSaved && hasRecorded)
  }


}
extension UIView {
  func setVisible(visible: Bool) {
    isHidden = !visible
  }
}
