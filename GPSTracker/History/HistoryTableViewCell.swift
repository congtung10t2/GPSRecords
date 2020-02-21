//
//  HistoryTableViewCell.swift
//  GPSTracker
//
//  Created by iMac on 2/21/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import Foundation
import UIKit
class HistoryTableViewCell: UITableViewCell {
  @IBOutlet weak var gpxName: UILabel!
  @IBOutlet weak var gpxTime: UILabel!
  func configure(model: LocationModel) {
    gpxName.text = model.name
    gpxTime.text = model.getDateAsString()
  }
}
