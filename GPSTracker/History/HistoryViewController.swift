//
//  HistoryViewController.swift
//  GPSTracker
//
//  Created by iMac on 2/20/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  private var showingData: Bool = false
  var items: [LocationModel] = []
  @IBOutlet weak var tableView :UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
      self.items = CoreDataManager.shared.getDataByName()
      tableView.reloadData()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    self.items = CoreDataManager.shared.getDataByName()
    tableView.reloadData()
  }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell
      else {
        return UITableViewCell()
    }
    cell.configure(model: items[indexPath.row])
    
    return cell
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("Deleted")
      let data = items.remove(at: indexPath.row)
      CoreDataManager.shared.removeDataByName(name: data.name)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    CoreDataManager.shared.fromCloudTab = false
    CoreDataManager.shared.locationShowing = CoreDataManager.shared.getDataByName(name: items[indexPath.row].name)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
    present(controller, animated: true, completion: nil)
  }
}
