//
//  TransactionCategory.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/12/16.
//
//

import Foundation
import RealmSwift

class TransactionCategory: Object {
    dynamic var name: String = " "
    dynamic var type: String = " "
    dynamic var icon: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
