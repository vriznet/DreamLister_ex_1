//
//  Image+CoreDataProperties.swift
//  DreamLister_ex_1
//
//  Created by vriz on 2018. 6. 26..
//  Copyright © 2018년 vriz. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?
}
