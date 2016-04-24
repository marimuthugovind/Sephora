//
//  Category.swift
//  HappyShop
//
//  Created by Marimuthu on 4/21/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit

class Category: NSObject {
  var name: String
  var noOfProducts:Int
  
  init(name : String , noOfProducts : Int) {
    self.name = name;
    self.noOfProducts = noOfProducts;
    super.init();
  }
  

}
