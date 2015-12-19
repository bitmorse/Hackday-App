//
//  JSAppStoreTableViewController
//  NervousMagicApps
//
//  Description: Gets the list of apps from server, displays to user, handles app "open" requests

//  Created by Sam Sulaimanov on 19/12/15.
//  Copyright © 2015 ethz. All rights reserved.
//

import UIKit
import Foundation

class JSAppStoreTableViewController: UITableViewController {
    
    //http://api.jsoneditoronline.org/v1/docs/14d584687bb4024c6413b967d7c78297
 
    var TableData = Array<Array<String>>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //get app listing json
        let endpoint = NSURL(string: "https://raw.githubusercontent.com/sid027/Hackday-App/master/NervousMagicApps/NervousMagicApps/nervous-resources/nervousAppList.json")
        let data = NSData(contentsOfURL: endpoint!)
        let json = JSON(data: data!);
        
        //fill tableview controller
        for (_,app) in json{
            let arrayOfStrings: [String] = [app["app"]["name"].string!, app["app"]["name"].string!, app["app"]["description"].string!];
            TableData.append(arrayOfStrings)
        }
        
        
        self.tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("appstoreCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = TableData[indexPath.row][0]
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(TableData[row][0])")

        performSegueWithIdentifier("JSAppSegue", sender: TableData[row][0])
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "JSAppSegue" {
           
            if let JSAppViewController = segue.destinationViewController as? JSAppViewController {
                JSAppViewController.JSAppName = (sender as? String)!;
            }
            
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    


}

