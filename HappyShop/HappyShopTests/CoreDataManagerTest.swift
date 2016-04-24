//
//  CoreDataManagerTest.swift
//  HappyShop
//
//  Created by Marimuthu on 4/24/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import XCTest
import CoreData
@testable import HappyShop


class CoreDataManagerTest: XCTestCase {
  
  var storeCoordinator: NSPersistentStoreCoordinator!
  var managedObjectContext: NSManagedObjectContext!
  var managedObjectModel: NSManagedObjectModel!
  var store: NSPersistentStore!
  

  var testRecord: ProductModel!

  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
      
      managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
      storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
      store = try? storeCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
      
      managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
      managedObjectContext.persistentStoreCoordinator = storeCoordinator
    
      testRecord = ProductModel();
      testRecord.productId = 88;
      testRecord.name = "Dirty Martini 15ml";
      testRecord.price = 2300.0;
      testRecord.category = "Nails";
      testRecord.imageUrl = "http://luxola-assets-staging-hades.s3.amazonaws.com/images/pictures/1754/default_f9b2aa04cf3a456fa6c195059d765ea669f3573d_NCLA_dirtymartini.png";
      testRecord.prodDescription = "Lorem ipsum dolor sit amet Dirty Martini 15ml product description consectetur adipiscing elit"


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
  
  
  func testInsertObjectAndCountProducts() {
    CoreDataManager.sharedInstance.insertNewProduct(testRecord);
    let totalProducts = CoreDataManager.sharedInstance.countOfProductsAtCart();
    XCTAssert(totalProducts>1, "Once product added, it's count should be more than 1");
    XCTAssertFalse(totalProducts<=0);
    
  }
  
  
}
