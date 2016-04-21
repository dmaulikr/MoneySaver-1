//
//  SelectAccountTypeTableViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/18/16.
//
//

import UIKit
import RealmSwift

protocol selectAccountType {
    func selectAccountType(accountType: AccountType)
}

class SelectAccountTypeTableViewController: UITableViewController, selectNewAccountType {
    
    var accountTypes = [AccountType]()
    var accountTypeIndex: Int = 7
    var accountTypeCount: Int = 7
    var delegate: NewAccountTableViewController? = nil

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
        return accountTypes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Type", forIndexPath: indexPath) as! AccountTypeTableViewCell
        
        let accountType = accountTypes[indexPath.row]
        
        cell.accountTypeName.text = accountType.name
        
        cell.accountTypeIcon.image = UIImage(data: accountType.icon!)
        cell.accountTypeIcon.contentMode = .ScaleAspectFit
        cell.accountTypeIcon.layer.cornerRadius = 7
        cell.accountTypeIcon.clipsToBounds = true
        
        if (indexPath.row == accountTypeIndex) {
            cell.checkmark.hidden = false
        }
        else {
            cell.checkmark.hidden = true
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Account Type was selected.")
        
        if ((tableView.cellForRowAtIndexPath(indexPath) as! AccountTypeTableViewCell).checkmark.hidden) {
            (tableView.cellForRowAtIndexPath(indexPath) as! AccountTypeTableViewCell).checkmark.hidden = false
            let auxiliarIndexPath = NSIndexPath(forRow: accountTypeIndex, inSection: 0)
            (tableView.cellForRowAtIndexPath(auxiliarIndexPath) as! AccountTypeTableViewCell).checkmark.hidden = true
            accountTypeIndex = indexPath.row
            delegate?.selectAccountType(accountTypes[accountTypeIndex])
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
        let nextViewController = segue.destinationViewController as! NewAccountTypeTableViewController
        nextViewController.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func selectNewAccountType() {
        accountTypeIndex = accountTypeCount
        loadTableViewData()
        delegate?.selectAccountType(accountTypes[accountTypeIndex])
        navigationController?.popViewControllerAnimated(true)
    }
    
    func loadTableViewData() {
        // Fetch Account Type
        
        let realm = try! Realm()
        let accountTypeResults = realm.objects(AccountType)
        
        print("Total account types ", accountTypeResults.count)
        
        self.accountTypes.removeAll()
        
        for accountType in accountTypeResults {
            self.accountTypes += [accountType]
        }
        
        accountTypeCount = accountTypes.count
        
        self.tableView.reloadData()
    }
    
    func reloadTableViewData() {
        print("Reloading data.")
        loadTableViewData()
    }
}
