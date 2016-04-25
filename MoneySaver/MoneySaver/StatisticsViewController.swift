//
//  StatisticsViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/18/16.
//
//

import UIKit
import RealmSwift


class StatisticsViewController: UIViewController {

    @IBOutlet var txfSaldoTotal: UITextField!
    @IBOutlet var txfIngresosTotales: UITextField!
    @IBOutlet var txfEgresosTotales: UITextField!
    
    var transactions = [Transaction]()
    var transactionIndex: Int = 0

    var accounts = [Account]()
    var accountIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.3372549, green: 0.54509804, blue: 0.8, alpha: 1.0)]
        loadTableViewData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        loadTableViewData()
    }
    
    func loadTableViewData() {
        // Fetch Accounts
        
        let realm = try! Realm()
        let transactionResults = realm.objects(Transaction)
        
        print("Total transactions ", transactionResults.count)
        
        self.transactions.removeAll()
        
        for transaction in transactionResults {
            self.transactions += [transaction]
        }
        
        let accountResults = realm.objects(Account)
        
        print("Total accounts ", accountResults.count)
        
        self.accounts.removeAll()
        
        for account in accountResults {
            self.accounts += [account]
        }
        
        doMath()
        
    }
    
    func doMath () {
        
        //first we get total balance
        var totalBalance : Double = 0
        for account in accounts {
            totalBalance += account.actualBalance
        }
        
        let format = NSNumberFormatter()
        format.numberStyle = .CurrencyStyle
        
        txfSaldoTotal.text = format.stringFromNumber(NSNumber(double: totalBalance))
        
        //then, the incomes and outcomes
        var totalIncomes : Double = 0
        var totalOutcomes : Double = 0

        for transaction in transactions {
            if transaction.typeOfTransaction == "Income" {
                totalIncomes += transaction.quantity
            } else {
                totalOutcomes += transaction.quantity
            }
        }
        
        txfIngresosTotales.text = format.stringFromNumber(NSNumber(double: totalIncomes))
        txfEgresosTotales.text = format.stringFromNumber(NSNumber(double: totalOutcomes))
        
        
        
        
    }

}
