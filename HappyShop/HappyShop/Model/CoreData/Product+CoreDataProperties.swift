//
//  Product+CoreDataProperties.swift
//  HappyShop
//
//  Created by Marimuthu on 4/22/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var imageUrl: String?
    @NSManaged var price: NSNumber?
    @NSManaged var category: String?
    @NSManaged var desc: String?
    @NSManaged var onSale: NSNumber?

}
