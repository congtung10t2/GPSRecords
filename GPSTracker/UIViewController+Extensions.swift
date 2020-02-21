//
//  UIViewController+Extensions.swift
//  LocationData
//
//  Created by iMac on 2/20/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
  func showLoading() -> MBProgressHUD {
    return MBProgressHUD.showAdded(to: self.view, animated: true);
  }

  func hideLoading(hud : MBProgressHUD){
    hud.hide(animated: true);
  }
  func showAlert(title: String, message : String)  {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Đồng ý", style: .default))
    DispatchQueue.main.async(execute: {
      self.present(alertController, animated: true, completion: nil)
      
    })
    
  }
  func showAlertWithInput(title: String, message : String) -> UIAlertController {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    
    alertController.addTextField(configurationHandler: { textField in
      textField.placeholder = "Nhập tên bản ghi"
    })
    DispatchQueue.main.async(execute: {
      self.present(alertController, animated: true, completion: nil)
      
    })
    return alertController
    
  }
}
