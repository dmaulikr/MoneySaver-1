//
//  NewAccountTableViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/14/16.
//
//

import UIKit
import RealmSwift

protocol reloadAccountsOnTable {
    func reloadAccountsOnTable()
}

class NewAccountTableViewController: UITableViewController, selectAccountType, UITextFieldDelegate {
    
    @IBOutlet weak var newAccountName: UITextField!
    @IBOutlet weak var newAccountStartBalance: UITextField!
    @IBOutlet weak var newAccount_AccountTypeName: UILabel!
    @IBOutlet weak var newAccountChosenColor: UIView!
    @IBOutlet weak var firstAccountColorOption: UIButton!
    @IBOutlet weak var secondAccountColorOption: UIButton!
    @IBOutlet weak var thirdAccountColorOption: UIButton!
    @IBOutlet weak var fourthAccountColorOption: UIButton!
    @IBOutlet weak var fifthAccountColorOption: UIButton!
    @IBOutlet weak var sixthAccountColorOption: UIButton!
    
    var accountColors = [AccountColor]()
    let newAccount: Account? = Account()
    var accountTypeIndex: Int = 7
    var accountColorIndex: Int = 0
    var startBalance: Double? = 0.0
    var delegate: AccountViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newAccountChosenColor.layer.cornerRadius = 7
        firstAccountColorOption.layer.cornerRadius = 7
        secondAccountColorOption.layer.cornerRadius = 7
        thirdAccountColorOption.layer.cornerRadius = 7
        fourthAccountColorOption.layer.cornerRadius = 7
        fifthAccountColorOption.layer.cornerRadius = 7
        sixthAccountColorOption.layer.cornerRadius = 7
        
        newAccountName.delegate = self
        newAccountStartBalance.delegate = self
        
        loadNewAccountDefaultAccountType()
        loadDefaultAccountColors()

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
        return 4
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
        let nextViewController = segue.destinationViewController as! SelectAccountTypeTableViewController
        nextViewController.delegate = self
        nextViewController.accountTypeIndex = accountTypeIndex
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func selectAccountType(accountType: AccountType, withIndex index: Int) {
        newAccount?.accountType = accountType
        newAccount_AccountTypeName.text = newAccount?.accountType?.name
        accountTypeIndex = index
    }
    
    func loadNewAccountDefaultAccountType() {
        let realm = try! Realm()
        let defaultAccountType = realm.objects(AccountType).filter("name = 'Others'")
        newAccount?.accountType = defaultAccountType[0]
    }
    
    func loadDefaultAccountColors() {
        let realm = try! Realm()
        let accountColorResults = realm.objects(AccountColor)
        
        print("Total account colors ", accountColorResults.count)
        
        for accountColor in accountColorResults {
            accountColors += [accountColor]
        }
    }
    
    @IBAction func selectColorForNewAccount(sender: UIButton) {
        if (sender == firstAccountColorOption) {
            accountColorIndex = 0
        }
        else if (sender == secondAccountColorOption) {
            accountColorIndex = 1
        }
        else if (sender == thirdAccountColorOption) {
            accountColorIndex = 2
        }
        else if (sender == fourthAccountColorOption) {
            accountColorIndex = 3
        }
        else if (sender == fifthAccountColorOption) {
            accountColorIndex = 4
        }
        else {
            accountColorIndex = 5
        }
        
        newAccountChosenColor.backgroundColor = sender.backgroundColor
    }
    
    @IBAction func addNewAccount(sender: AnyObject) {
        let realm = try! Realm()
        
        newAccount?.accountName = newAccountName.text!
        newAccount?.startBalance = startBalance!
        newAccount?.actualBalance = startBalance!
        newAccount?.accountCreationDate = NSDate()
        newAccount?.accountColor = accountColors[accountColorIndex]
        
        try! realm.write {
            realm.add(newAccount!)
        }
        
        delegate?.loadTableViewData()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == newAccountName) {
            // Does nothing.
        }
        else {
            newAccountStartBalance.text = "\(startBalance!)"
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == newAccountName) {
            // Does nothing.
        }
        else {
            startBalance = Double(newAccountStartBalance.text!)!
            
            if (startBalance != nil) {
                newAccountStartBalance.text = "$" + "\(startBalance!)"
            }
            else {
                newAccountStartBalance.text = "$0.0"
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == newAccountName) {
            newAccountStartBalance.becomeFirstResponder()
        }
        else {
            newAccountStartBalance.resignFirstResponder()
        }
        
        return true
    }
}
