//
//  ResponseParser.swift
//  HappyShop
//
//  Created by Marimuthu on 4/21/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit

class ResponseParser: NSObject {
  /**
   Method to parse the category list from the response dictionary
   
   - parameter passonResponse: response dictionary from service class
   
   - returns: Array of categories
   */
  class func parseCategoriesResponse(passonResponse:NSDictionary) -> NSArray {
    
    let categories = NSMutableArray();
    
    let receivedCategories = passonResponse.objectForKey("categories") as! NSArray
    
    for category in receivedCategories {
      let name = category.objectForKey("name") as! String ;
      let noOfProducts = category.objectForKey("products_count") as! Int;
      
      let tempCategory = Category(name: name, noOfProducts: noOfProducts);
      
      categories.addObject(tempCategory);
    }
    
    return categories;
  }
  
  /**
   Method to parse the product list from the response dictionary
   
   - parameter passonResponse: response dictionary from service class
   
   - returns: Array of products
   */
  class func parseProductListResponse(passonResponse:NSDictionary) -> NSArray {
    
    let products = NSMutableArray();
    
    let receivedProducts = passonResponse.objectForKey("products") as! NSArray
    
    for product in receivedProducts {
      
      let tempProduct =  ProductModel();
      tempProduct.productId = product.objectForKey("id") as? Int;
      tempProduct.name = product.objectForKey("name") as? String ;
      tempProduct.category = product.objectForKey("category") as? String ;
      tempProduct.price = product.objectForKey("price") as? Float ;
      tempProduct.imageUrl = product.objectForKey("img_url") as? String ;
      tempProduct.isUnderSale = product.objectForKey("under_sale") as? Bool ;
      let prodDesc = product.objectForKey("description") as? String;
      if(prodDesc?.isEmpty == false){
        tempProduct.prodDescription = prodDesc;
      }
      products.addObject(tempProduct);
    }
    
    return products;
  }
  
  /**
   Method to parse the product detail
   
   - parameter passonResponse: response dictionary from service class
   
   - returns: Details of particular product of type ProductModel
   */

  class func parseProductDetailResponse(passonResponse:NSDictionary) -> ProductModel {
    
    let receivedProd = passonResponse.objectForKey("product") as! NSDictionary
    
    let tempProduct =  ProductModel();
    tempProduct.productId = receivedProd.objectForKey("id") as? Int;
    tempProduct.name = receivedProd.objectForKey("name") as? String ;
    tempProduct.category = receivedProd.objectForKey("category") as? String ;
    tempProduct.price = receivedProd.objectForKey("price") as? Float ;
    tempProduct.imageUrl = receivedProd.objectForKey("img_url") as? String ;
    tempProduct.isUnderSale = receivedProd.objectForKey("under_sale") as? Bool ;
    tempProduct.prodDescription = receivedProd.objectForKey("description") as? String;
    return tempProduct;
  }
  
  
}
