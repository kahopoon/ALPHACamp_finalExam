//
//  BookList_TableViewController.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SDWebImage
import SwiftyJSON
import PKHUD

class BookList_TableViewController: UITableViewController {

    var bookList:[BookDataInfo] = []
    
    override func viewWillAppear(animated: Bool) {
        // get content from server
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview cell auto height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0

        // pull to refresh
        self.refreshControl?.addTarget(self, action: #selector(BookList_TableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh() {
        HUD.show(.LabeledProgress(title: "書本列表載入中", subtitle: "請稍候。。。"))
        getBookListFromFirebase { (result) in
            if result.isEmpty {
                self.noInternetAlert()
            } else {
                // reverse sort order, reload table, hide progress hud
                self.bookList = result.reverse()
                HUD.hide({ (true) in
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
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
        return bookList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookList_TableViewCell", forIndexPath: indexPath) as! BookList_TableViewCell

        if let id = bookList[indexPath.row].bookID, let name = bookList[indexPath.row].bookName, image = bookList[indexPath.row].coverImage {
            cell.bookID.text = id
            cell.bookName.text = name
            cell.coverImage.image = UIImage(data: NSData(base64EncodedString: image, options: NSDataBase64DecodingOptions())!)
        }

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            delBookRequest(bookList[indexPath.row].bookID, completion: { (result) in
                self.resultAlert(result)
            })
        }
    }
    
    func resultAlert(result: Bool) {
        let alert = UIAlertController(title: "刪除狀態", message: result ? "成功" : "失敗", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "確定", style: result ? .Default : .Destructive) { (action) in
            self.refresh()
        }
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func noInternetAlert() {
        let alert = UIAlertController(title: "沒有網絡", message: "請檢查網絡", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "確定", style: .Destructive, handler: nil)
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // data pass to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if segue.identifier == "toBookDetails" {
                let vc = segue.destinationViewController as! BookDetails_ViewController
                vc.bookDetails = bookList[indexPath.row]
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
