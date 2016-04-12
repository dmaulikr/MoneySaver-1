//
//  Account.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/12/16.
//
//

import Foundation
import RealmSwift

class Account: Object {
    
    dynamic var accountName: String = " "
    dynamic var startBalance: Double = 0.0
    dynamic var accountCreationDate: NSDate = NSDate()
    dynamic var accountCategory: AccountType?
    dynamic var accountColor: AccountColor?
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
