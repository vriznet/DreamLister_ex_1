//
//  Item+CoreDataClass.swift
//  DreamLister_ex_1
//
//  Created by vriz on 2018. 6. 26..
//  Copyright © 2018년 vriz. All rights reserved.
//
//

import Foundation
import CoreData

public class Item: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
