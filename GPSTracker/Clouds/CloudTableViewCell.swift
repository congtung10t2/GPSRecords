//
//  CloudTableViewCell.swift
//  GPSTracker
//
//  Created by iMac on 2/21/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class CloudTableViewCell: UITableViewCell {
  @IBOutlet weak var gpxName: UILabel!
  func configure(model: StorageReference) {
    gpxName.text = model.name
  }
}
