//
//  Category.swift
//  Todo
//
//  Created by Achem Samuel on 2/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
   @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
