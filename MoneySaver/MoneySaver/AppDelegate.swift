//
//  AppDelegate.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/11/16.
//
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.3372549, green: 0.54509804, blue: 0.8, alpha: 1.0)
        loadDefaultAccountTypes()
        loadDefaultTransactionCategories()
        
        return true
    }
    
    func loadDefaultAccountTypes() {
        let realm = try! Realm()
        let accountTypes = realm.objects(AccountType)
        
        if (accountTypes.count == 0) {
            let accountTypeAsset = AccountType()
            accountTypeAsset.name = "Asset"
            accountTypeAsset.icon = UIImageJPEGRepresentation(UIImage(named: "Asset")!, 0.5)
            
            let accountTypeCash = AccountType()
            accountTypeCash.name = "Cash"
            accountTypeCash.icon = UIImageJPEGRepresentation(UIImage(named: "Cash")!, 0.5)
            
            let accountTypeChecking = AccountType()
            accountTypeChecking.name = "Checking"
            accountTypeChecking.icon = UIImageJPEGRepresentation(UIImage(named: "Checking")!, 0.5)
            
            let accountTypeCreditCard = AccountType()
            accountTypeCreditCard.name = "Credit Card"
            accountTypeCreditCard.icon = UIImageJPEGRepresentation(UIImage(named: "Credit Card")!, 0.5)
            
            let accountTypeDebitCard = AccountType()
            accountTypeDebitCard.name = "Debit Card"
            accountTypeDebitCard.icon = UIImageJPEGRepresentation(UIImage(named: "Debit Card")!, 0.5)
            
            let accountTypeInvesting_Retirement = AccountType()
            accountTypeInvesting_Retirement.name = "Investing/Retirement"
            accountTypeInvesting_Retirement.icon = UIImageJPEGRepresentation(UIImage(named: "InvestingRetirement")!, 0.5)
            
            let accountTypeLoan = AccountType()
            accountTypeLoan.name = "Loan"
            accountTypeLoan.icon = UIImageJPEGRepresentation(UIImage(named: "Loan")!, 0.5)
            
            let accountTypeOthers = AccountType()
            accountTypeOthers.name = "Others"
            accountTypeOthers.icon = UIImageJPEGRepresentation(UIImage(named: "Others")!, 0.5)
            
            let accountTypeSavings = AccountType()
            accountTypeSavings.name = "Savings"
            accountTypeSavings.icon = UIImageJPEGRepresentation(UIImage(named: "Savings")!, 0.5)
            
            try! realm.write {
                realm.add(accountTypeAsset)
                realm.add(accountTypeCash)
                realm.add(accountTypeChecking)
                realm.add(accountTypeCreditCard)
                realm.add(accountTypeDebitCard)
                realm.add(accountTypeInvesting_Retirement)
                realm.add(accountTypeLoan)
                realm.add(accountTypeOthers)
                realm.add(accountTypeSavings)
            }
        }
        else {
            print("The total quantity of account types is: ", accountTypes.count, "\n")
        }
        
    }
    
    func loadDefaultTransactionCategories() {
        let realm = try! Realm()
        let transactionCategories = realm.objects(TransactionCategory)
        
        if (transactionCategories.count == 0) {
        }
        else {
            // Does nothing.
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

