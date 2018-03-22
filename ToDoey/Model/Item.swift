//
//  Item.swift
//  ToDoey
//
//  Created by Tran Uy Du on 21/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateTime : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
