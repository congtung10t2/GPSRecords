//
//  CloudsViewController.swift
//  GPSTracker
//
//  Created by iMac on 2/21/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import Foundation
import MapKit
import Firebase
class CloudsViewController : UIViewController {
    private var showingData: Bool = false
    var items: [StorageReference] = []
    @IBOutlet weak var tableView :UITableView!
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      CoreDataManager.shared.getAllCloudsData { (value, error) in
        if let value = value {
          self.items = value
          self.tableView.reloadData()
          print(value)
        }
      }
      self.tableView.reloadData()
    }
  }

  extension CloudsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CloudTableViewCell", for: indexPath) as? CloudTableViewCell
        else {
          return UITableViewCell()
      }
      cell.configure(model: items[indexPath.row])
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let loading = self.showLoading()
      let data = items[indexPath.row]
      data.getData(maxSize: 1 * 1024 * 1024) { data, error in
        self.hideLoading(hud: loading)
        do {
          let decoder = JSONDecoder()
          let tracker = try decoder.decode(Tracker.self, from: data!)
          CoreDataManager.shared.fromCloudTab = true
          CoreDataManager.shared.locationShowing = tracker.toLocationModels()
          self.showingData = true
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
          self.present(controller, animated: true, completion: nil)
        } catch {
          
        }
        
      }
      
    }
  }
