//
//  Category.swift
//  ToDoey
//
//  Created by Tran Uy Du on 21/03/2018.
//  Copyright © 2018 Tran Uy Du. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
