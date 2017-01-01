//
//  Model.swift
//  RealmSwift
//
//  Created by Aaqib Hussain on 31/12/16.
//  Copyright © 2016 Aaqib Hussain. All rights reserved.
//

import UIKit
import RealmSwift

class Model: Object {
    
    dynamic var name : String?

    dynamic var id : String?
    
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
