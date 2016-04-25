//
//  SelectTransactionCategoryTableViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/24/16.
//
//

import UIKit
import RealmSwift

protocol selectTransactionCategory {
    func selectTransactionCategory(transactionCategory: TransactionCategory, withIndex index: Int)
}

class SelectTransactionCategoryTableViewController: UITableViewController, selectNewTransactionCategory {
    
    var transactionCategories = [TransactionCategory]()
    var transactionCategoryIndex: Int!
    var transactionCategoryCount: Int!
    var typeOfTransaction: String!
    var delegate: NewTransactionTableViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableViewData()

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactionCategories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as! TransactionCategoryTableViewCell

        let transactionCategory = transactionCategories[indexPath.row]
        
        cell.transactionCategoryName.text = transactionCategory.name
        
        if (indexPath.row == transactionCategoryIndex) {
            cell.checkmark.hidden = false
        }
        else {
            cell.checkmark.hidden = true
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Transaction Category was selected")
        
        if ((tableView.cellForRowAtIndexPath(indexPath) as! TransactionCategoryTableViewCell).checkmark.hidden) {
            (tableView.cellForRowAtIndexPath(indexPath) as! TransactionCategoryTableViewCell).checkmark.hidden = false
            
            //let auxiliarIndexPath = NSIndexPath(forRow: transactionCategoryIndex, inSection: 0)
            
            //(tableView.cellForRowAtIndexPath(auxiliarIndexPath) as! TransactionCategoryTableViewCell).checkmark.hidden = true
            
            transactionCategoryIndex = indexPath.row
            
            delegate?.selectTransactionCategory(transactionCategories[transactionCategoryIndex], withIndex: transactionCategoryIndex)
            navigationController?.popViewControllerAnimated(true)
        }
        else {
            // Does nothing.
        }
    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextViewController = segue.destinationViewController as! NewTransactionCategoryTableViewController
        nextViewController.delegate = self
        nextViewController.typeOfTransaction = typeOfTransaction
    }
    
    func selectNewTransactionCategory() {
        transactionCategoryIndex = transactionCategoryCount
        loadTableViewData()
        delegate?.selectTransactionCategory(transactionCategories[transactionCategoryIndex], withIndex: transactionCategoryIndex)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func loadTableViewData() {
        // Fetch Account Type
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "type = %@", typeOfTransaction)
        let transactionCategoryResults = realm.objects(TransactionCategory).filter(predicate)
        
        print("Total filtered transaction categories ", transactionCategoryResults.count)
        
        self.transactionCategories.removeAll()
        
        for transactionCategory in transactionCategoryResults {
            self.transactionCategories += [transactionCategory]
        }
        
        transactionCategoryCount = transactionCategories.count
        
        self.tableView.reloadData()
    }
    
    func reloadTableViewData() {
        print("Reloading data.")
        loadTableViewData()
    }
}
