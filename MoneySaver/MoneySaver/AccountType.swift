//
//  AccountType.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/12/16.
//
//

import Foundation
import RealmSwift

class AccountType: Object {
    dynamic var name: String = " "
    dynamic var icon: NSData? = nil
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
