//
//  AccountColor.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/12/16.
//
//

import Foundation
import RealmSwift

class AccountColor: Object {
    dynamic var red: Float = 1.0
    dynamic var green: Float = 1.0
    dynamic var blue: Float = 1.0
    dynamic var alpha: Float = 1.0
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
