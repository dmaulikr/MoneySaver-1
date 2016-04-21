//
//  NewAccountTypeTableViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/18/16.
//
//

import UIKit
import RealmSwift

protocol selectNewAccountType {
    func selectNewAccountType()
}

class NewAccountTypeTableViewController: UITableViewController {
    
    @IBOutlet weak var newAccountTypeName: UITextField!
    @IBOutlet weak var newAccountTypeIcon: UIImageView!
    
    var delegate: selectNewAccountType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newAccountTypeIcon.contentMode = .ScaleAspectFit

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
        return 2
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func setAccountTypeIcon(sender: UIButton) {
        newAccountTypeIcon.image = sender.imageView?.image
    }

    @IBAction func addNewAccountType(sender: AnyObject) {
        if (newAccountTypeName.text == "") {
            let alert = UIAlertController(title: "Warning", message: "At least provide a type name.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Cancel)
            { (alertAction) -> Void in
                
            }
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let realm = try! Realm()
            
            let newAccountType = AccountType()
            newAccountType.name = newAccountTypeName.text!
            newAccountType.icon = UIImageJPEGRepresentation(newAccountTypeIcon.image!, 0.5)
            
            do {
                try realm.write {
                    realm.add(newAccountType)
                }
                
                delegate?.selectNewAccountType()
                
                navigationController?.popViewControllerAnimated(true)
            }
            catch {
                print("Write operation either failed or account type name already exists.")
                
                let alert = UIAlertController(title: "Warning", message: "Type name already exists.", preferredStyle: .Alert)
                
                let action = UIAlertAction(title: "Ok", style: .Cancel)
                { (alertAction) -> Void in
                    
                }
                alert.addAction(action)
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
