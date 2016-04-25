//
//  NewTransactionTableViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/24/16.
//
//

import UIKit
import RealmSwift

class NewTransactionTableViewController: UITableViewController, UITextFieldDelegate, selectTransactionCategory, selectTransactionAccount {
    
    @IBOutlet weak var newTransactionPayee: UITextField!
    @IBOutlet weak var newTransactionAmount: UITextField!
    @IBOutlet weak var newTransaction_TransactionCategoryName: UILabel!
    @IBOutlet weak var newTransactionRelatedAccountName: UILabel!
    
    let newTransaction: Transaction? = Transaction()
    var transactionCategoryIndex: Int = 0
    var transactionRelatedAccountIndex: Int = 0
    var amount: Double? = 0.0
    var delegate: TransactionViewController? = nil
    let redColor = UIColor(red: 1.0, green: 0.35686275, blue: 0.41568627, alpha: 1.0)
    let greenColor = UIColor(red: 0.38823529, green: 0.55294118, blue: 0.41568627, alpha: 1.0)
    var typeOfTransaction = "Expense"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTransactionPayee.delegate = self
        newTransactionAmount.delegate = self
        
        loadNewTransactionDefaultTransactionCategory()
        loadNewTransactionDefaultTransactionRelatedAccount()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .NoStyle
            dateFormatter.dateStyle = .MediumStyle
            
            return dateFormatter.stringFromDate(NSDate())
        }
        else {
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        
        if (section == 0) {
            // Text Color/Font
            let header = view as! UITableViewHeaderFooterView
            header.textLabel!.textColor = UIColor.grayColor()
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .NoStyle
            dateFormatter.dateStyle = .MediumStyle
            header.textLabel!.text = dateFormatter.stringFromDate(NSDate())
        }
        else {
            // Does nothing.
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SelectCategory") {
            let nextViewController = segue.destinationViewController as! SelectTransactionCategoryTableViewController
            nextViewController.delegate = self
            nextViewController.transactionCategoryIndex = transactionCategoryIndex
            nextViewController.typeOfTransaction = typeOfTransaction
        }
        else {
            let nextViewController = segue.destinationViewController as! SelectTransactionAccountTableViewController
            nextViewController.delegate = self
            nextViewController.transactionAccountIndex = transactionRelatedAccountIndex
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func changeTransactionType(sender: UISegmentedControl) {
        transactionCategoryIndex = 0
        
        if (sender.selectedSegmentIndex == 0) {
            sender.tintColor = greenColor
            typeOfTransaction = "Income"
        }
        else {
            sender.tintColor = redColor
            typeOfTransaction = "Expense"
        }
        
        loadNewTransactionDefaultTransactionCategory()
    }
    
    func selectTransactionCategory(transactionCategory: TransactionCategory, withIndex index: Int) {
        newTransaction?.category = transactionCategory
        newTransaction_TransactionCategoryName.text = newTransaction?.category?.name
        transactionCategoryIndex = index
    }
    
    func selectTransactionAccount(transactionAccount: Account, withIndex index: Int) {
        newTransaction?.account = transactionAccount
        newTransactionRelatedAccountName.text = newTransaction?.account?.accountName
        transactionRelatedAccountIndex = index
    }
    
    func loadNewTransactionDefaultTransactionCategory() {
        let realm = try! Realm()
        
        if (typeOfTransaction == "Income") {
            let defaultTransactionCategory = realm.objects(TransactionCategory).filter("name = 'Bonus'")
            newTransaction?.category = defaultTransactionCategory[0]
            newTransaction_TransactionCategoryName.text = defaultTransactionCategory[0].name
        }
        else {
            let defaultTransactionCategory = realm.objects(TransactionCategory).filter("name = 'Gas'")
            newTransaction?.category = defaultTransactionCategory[0]
            newTransaction_TransactionCategoryName.text = defaultTransactionCategory[0].name
        }
    }
    
    func loadNewTransactionDefaultTransactionRelatedAccount() {
        let realm = try! Realm()
        let accountResults = realm.objects(Account)
        
        newTransactionRelatedAccountName.text = accountResults[0].accountName
        newTransaction?.account = accountResults[0]
    }
    
    @IBAction func addNewTransaction(sender: AnyObject) {
        let realm = try! Realm()
        
        newTransaction?.payee = newTransactionPayee.text!
        newTransaction?.typeOfTransaction = typeOfTransaction
        newTransaction?.quantity = amount!
        newTransaction?.date = NSDate()
        
        try! realm.write {
            realm.add(newTransaction!)
        }
        
        try! realm.write {
            newTransaction?.account?.accountTransactions.append(newTransaction!)
            
            if (typeOfTransaction == "Income") {
                print("Income")
                let newActualBalance = (newTransaction?.account?.actualBalance)! + (newTransaction?.quantity)!
                newTransaction?.account?.actualBalance = newActualBalance
            }
            else {
                print("Expense")
                let newActualBalance = (newTransaction?.account?.actualBalance)! - (newTransaction?.quantity)!
                newTransaction?.account?.actualBalance = newActualBalance
            }
        }
        
        delegate?.loadTableViewData()
        navigationController?.popViewControllerAnimated(true)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == newTransactionPayee) {
            // Does nothing.
        }
        else {
            newTransactionAmount.text = "\(amount!)"
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == newTransactionPayee) {
            // Does nothing.
        }
        else {
            amount = Double(newTransactionAmount.text!)!
            
            if (amount != nil) {
                newTransactionAmount.text = "$" + "\(amount!)"
            }
            else {
                newTransactionAmount.text = "$0.0"
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == newTransactionPayee) {
            newTransactionAmount.becomeFirstResponder()
        }
        else {
            newTransactionAmount.resignFirstResponder()
        }
        
        return true
    }
}
