//
//  Product+CoreDataProperties.swift
//  A2_FA_iOS_Vijay_C0800126
//
//  Created by MacStudent on 2021-05-28.
//  Copyright © 2021 MacStudent. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var detail: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var provider: Provider?

}
