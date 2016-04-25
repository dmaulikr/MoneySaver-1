//
//  TransactionViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/13/16.
//
//

import UIKit
import RealmSwift

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var transactionTable: UITableView!
    
    var transactions = [Transaction]()
    var transactionIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionTable.delegate = self
        transactionTable.dataSource = self

        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.3372549, green: 0.54509804, blue: 0.8, alpha: 1.0)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Account", forIndexPath: indexPath) as! TransactionTableViewCell
        
        let transaction = transactions[indexPath.row]
        
        cell.transactionPayee.text = transaction.payee
        cell.relatedAccountName.text = transaction.account?.accountName
        cell.transactionAmount.text = "$" + "\(transaction.quantity)"
        
        if (transaction.typeOfTransaction == "Income") {
            cell.transactionAmount.textColor = UIColor.greenColor()
        }
        else {
            cell.transactionAmount.textColor = UIColor.redColor()
        }
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextViewController = segue.destinationViewController as! NewTransactionTableViewController
        nextViewController.delegate = self
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let realm = try! Realm()
        let accountResults = realm.objects(Account)
        
        if (accountResults.count == 0) {
            let alert = UIAlertController(title: "Warning", message: "No accounts found. Please create one before creating a transaction.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Cancel)
            { (alertAction) -> Void in
                
            }
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
            return false
        }
        else {
            return true
        }
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
        
        self.transactionTable.reloadData()
    }
    
    func reloadTableViewData() {
        print("Reloading data.")
        loadTableViewData()
    }

}
