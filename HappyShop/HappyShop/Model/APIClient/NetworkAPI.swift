//
//  NetworkAPI.swift
//  HappyShop
//
//  Created by Marimuthu on 4/21/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit
import Alamofire



class NetworkAPI: NSObject {

  static let kBaseUrl = "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/"
  static let kCategoriesUrl = kBaseUrl+"categories.json"
  static let kProductListUrl = kBaseUrl+"products.json"
  static let kProductDetailUrl = kBaseUrl+"products/"

  /**
   Method to make web service call to get the list of categories
   
   - parameter onSuccess: 
        closure to be called while client received data. This closure takes array of categories as input param
   - parameter onError:   
        closure to be called during any error
   */
  class func getCategories (onSuccess:(categories:NSArray) -> Void , onError:(error:NSError) -> Void ){
    
    Alamofire.request(.GET, kCategoriesUrl, parameters: nil)
      .responseJSON {
        response in
        
        switch response.result
        {
        case .Success(let JSON):
          
          print("Success @ Categories: \(JSON)")
          
          let response = JSON as! NSDictionary

          onSuccess(categories:  ResponseParser.parseCategoriesResponse(response));
         
          
        case .Failure(let error):
          print("Request failed with error: \(error)")
          onError(error: error);
          
        }
    }
  }
  
  /**
   Method to make web service call to get the list of categories
   
   - parameter onSuccess:
   closure to be called while client received data. This closure takes array of products as input param
   - parameter onError:
   closure to be called during any error
   */
  class func getProductListForCategories (pageNo:Int,category:String, onSuccess:(products:NSArray) -> Void , onError:(error:NSError) -> Void ){
  
    // Parameters to be appeneded with the request
    let params:[String : AnyObject] = ["page": pageNo,"category":category];

    Alamofire.request(.GET, kProductListUrl, parameters: params)
      .responseJSON {
        response in
        
        switch response.result
        {
        case .Success(let JSON):
          
          print("Success @ Product List: \(JSON)")
          
          let response = JSON as! NSDictionary
          if let errorMessage = response.objectForKey("error") {
            let errorCode = response.objectForKey("code") as! Int
            let errorObj : NSError = NSError(domain: "Error", code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage]);
             onError(error: errorObj);
          }
          else{
            onSuccess(products:  ResponseParser.parseProductListResponse(response));
          }
          
        case .Failure(let error):
          print("Request failed with error: \(error)")
          onError(error: error);
          
        }
    }
  }
  
  
  /**
   Method to make web service call to get the list of categories
   
   - parameter onSuccess:
   closure to be called while client received data. This closure takes Products deatil data as input param
   - parameter onError:
   closure to be called during any error
   */
  class func getProductDetails (productId:Int, onSuccess:(product:ProductModel) -> Void , onError:(error:NSError) -> Void ){

    Alamofire.request(.GET,kProductDetailUrl+String(productId)+".json", parameters:nil)
      .responseJSON {
        response in
        
        switch response.result
        {
        case .Success(let JSON):
          
          print("Success @ Product Detail: \(JSON)")
          
          let response = JSON as! NSDictionary
          
          
          if let errorMessage = response.objectForKey("error") {
            let errorCode = Int(response.objectForKey("status") as! String)
            let errorObj : NSError = NSError(domain: "Error", code: errorCode!, userInfo: [NSLocalizedDescriptionKey: errorMessage]);
            onError(error: errorObj);
          }
          else{
            onSuccess(product:ResponseParser.parseProductDetailResponse(response));
          }
        case .Failure(let error):
          print("Request failed with error: \(error)")
          onError(error: error);
          
        }
    }
  }

  

}
