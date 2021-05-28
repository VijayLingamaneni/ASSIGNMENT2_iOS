//
//  Provider+CoreDataProperties.swift
//  A2_FA_iOS_Vijay_C0800126
//
//  Created by MacStudent on 2021-05-28.
//  Copyright © 2021 MacStudent. All rights reserved.
//
//

import Foundation
import CoreData


extension Provider {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Provider> {
        return NSFetchRequest<Provider>(entityName: "Provider")
    }

    @NSManaged public var name: String?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for product
extension Provider {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Product)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Product)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}
