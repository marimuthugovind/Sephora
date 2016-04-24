//
//  CommonUtils.swift
//  HappyShop
//
//  Created by Marimuthu on 4/24/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit

class CommonUtils: NSObject {

  /**
   Method to present the Error dialog to the user
   */
  class func showErrorAlert(message:String ,inController:UIViewController){
    
    let alertController: UIAlertController =
    
    UIAlertController(title: "Error",
      message: message,
      preferredStyle: .Alert)
    
    
    let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
    
    }
    alertController.addAction(okAction)
    
    inController.presentViewController(alertController, animated: true, completion: nil)
  }
}
