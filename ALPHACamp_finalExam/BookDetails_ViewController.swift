//
//  BookDetails_ViewController.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit

class BookDetails_ViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookStore: UIButton!
    @IBOutlet weak var bookPhone: UIButton!
    @IBOutlet weak var bookURL: UIButton!
    @IBOutlet weak var bookDescription: UILabel!
    
    var bookDetails:BookDataInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = bookDetails.bookName
        coverImage.image = UIImage(data: NSData(base64EncodedString: bookDetails.coverImage, options: NSDataBase64DecodingOptions())!)
        bookName.text = bookDetails.bookName
        bookStore.setTitle(bookDetails.bookStore, forState: .Normal)
        bookPhone.setTitle(bookDetails.bookPhone, forState: .Normal)
        bookURL.setTitle(bookDetails.bookURL, forState: .Normal)
        bookDescription.text = bookDetails.bookDescription

        // Do any additional setup after loading the view.
    }

    @IBAction func phoneCall(sender: AnyObject) {
        if let telNo = sender.currentTitle {
            let alert = UIAlertController(title: "請確認", message: "打電話給\(telNo!)", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "取消", style: .Destructive, handler: nil)
            let confirmAction = UIAlertAction(title: "確定", style: .Default) { (action) in
                if let url = NSURL(string: "tel://\(telNo!)") {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // data pass to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBookWebView" {
            let vc = segue.destinationViewController as! WebView_ViewController
            vc.responseURL = bookDetails.bookURL
        } else if segue.identifier == "toBookMapView" {
            let vc = segue.destinationViewController as! MapView_ViewController
            vc.targetAddress = bookDetails.bookStore
        } else if segue.identifier == "toEnlargePhoto" {
            let vc = segue.destinationViewController as! PhotoView_ViewController
            vc.imageString = bookDetails.coverImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
