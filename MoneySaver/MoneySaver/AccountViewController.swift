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
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.3372549, green: 0.54509804, blue: 0.8, alpha: 1.0)]
        
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
        return accounts.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Account", forIndexPath: indexPath) as! AccountTableViewCell
        
        let account = accounts[indexPath.row]
        
        cell.accountName.text = account.accountName
        cell.accountType.text = account.accountType?.name
        
        cell.accountBalance.text = "$" + "\(account.actualBalance)"
        cell.accountIcon.image = UIImage(data: (account.accountType?.icon)!)
        cell.accountIcon.contentMode = .ScaleAspectFit
        
        let red: CGFloat = CGFloat((account.accountColor?.red)!)
        let green: CGFloat = CGFloat((account.accountColor?.green)!)
        let blue: CGFloat = CGFloat((account.accountColor?.blue)!)
        let alpha: CGFloat = CGFloat((account.accountColor?.alpha)!)
        
        cell.accountName.textColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        cell.accountType.textColor = UIColor(red: red, green: green, blue: blue, alpha: alpha - 0.3)
     
        return cell
     }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! NewAccountTableViewController
        nextViewController.delegate = self
    }
    
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
