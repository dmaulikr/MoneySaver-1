//
//  AccountViewController.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/13/16.
//
//

import UIKit
import RealmSwift

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var accountTable: UITableView!
    
    var accounts = [Account]()
    var accountIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountTable.delegate = self
        accountTable.dataSource = self
        
        loadTableViewData()
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
        return 0
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("Account", forIndexPath: indexPath) as! AccountTableViewCell
     
     
     
     return cell
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadTableViewData() {
        // Fetch Accounts
        
        let realm = try! Realm()
        let accountResults = realm.objects(Account)
        
        print("Total accounts ", accountResults.count)
        
        self.accounts.removeAll()
        
        for account in accountResults {
            self.accounts += [account]
        }
        
        self.accountTable.reloadData()
    }
    
    func reloadTableViewData() {
        print("Reloading data.")
        loadTableViewData()
    }
}
