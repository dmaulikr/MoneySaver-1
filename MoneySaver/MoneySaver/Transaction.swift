//
//  Transaction.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/12/16.
//
//

import Foundation
import RealmSwift

class Transaction: Object {
    dynamic var payee: String = " "
    dynamic var typeOfTransaction: String = " "
    dynamic var quantity: Double = 0.0
    dynamic var category: TransactionCategory?
    dynamic var account: Account?
    dynamic var date: NSDate = NSDate()
    //dynamic var photo: NSData? = nil
    //dynamic var memo: String = " "
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
