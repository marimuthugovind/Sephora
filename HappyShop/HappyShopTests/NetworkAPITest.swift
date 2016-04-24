//
//  NetworkAPITest.swift
//  HappyShop
//
//  Created by Marimuthu on 4/24/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import XCTest
@testable import HappyShop

class NetworkAPITest: XCTestCase {
  
  var categoriesResponse : NSArray!
  
  var prodListError : NSError!
  var categoriesError : NSError!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      self.categoriesResponse = NSArray();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
 
  func testGetCategories() {
   [NetworkAPI .getCategories({ (categories) -> Void in
      self.categoriesResponse = categories;
    },
    onError: { (error) -> Void in
      self.categoriesError = error;
   })];
//    
//    XCTAssertNotNil(self.prodListError, "Error should be nil for proper data");
//    XCTAssert(self.categoriesResponse.count < 0, "Response shouldn't be empty");
  }
  
  func testgetProductListForCategories(){
    [NetworkAPI .getProductListForCategories(1,
      category: "Men",
      onSuccess: { (products) -> Void in
      
      },
      onError: { (error) -> Void in
        self.prodListError = error;
    })];
    
    
//    XCTAssertNotNil(self.prodListError, "Error should be nil for proper data");
  }
}
