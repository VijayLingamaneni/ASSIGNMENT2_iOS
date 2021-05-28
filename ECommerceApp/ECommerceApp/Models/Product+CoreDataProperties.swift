//
//  Product+CoreDataProperties.swift
//  ECommerceApp
//
//
//  Created by VIJAYLINGAMANENI on 5/25/21.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var detail: String?
    @NSManaged public var provider: Provider?

}
