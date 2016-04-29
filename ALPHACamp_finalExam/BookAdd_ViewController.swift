//
//  BookAdd_ViewController.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit
import PKHUD

class BookAdd_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var coverImageString:String!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookName, bookStore, bookURL, bookPhone, bookDescription: UITextField!
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"]
        self.coverImage.image = image as? UIImage
        coverImageString = UIImageJPEGRepresentation(self.coverImage.image!, 0.3)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        // button appearance after image added
        addImageButton.alpha = 0
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func takePhotoAction(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submitNewBook(sender: AnyObject) {
        if userInputisValid() {
            // temporary disable button
            navigationItem.rightBarButtonItem?.enabled = false
            // just simplify, please do not mind of using mobile local time
            let bookInfoAdd = ["bookName":bookName.text!, "coverImage":coverImageString!, "bookURL":bookURL.text!, "bookStore":bookStore.text!, "bookDescription":bookDescription.text!, "timeStamp":"\(NSDate().timeIntervalSince1970 * 1000)", "bookPhone":bookPhone.text!]
            // add record
            addBookRequest(bookInfoAdd) { (result) in
                self.navigationItem.rightBarButtonItem?.enabled = true
                self.resultAlert(result ? true : false)
            }
        } else {
            inputInvalidAlert()
        }
    }
    
    func inputInvalidAlert() {
        let alert = UIAlertController(title: "輸入錯誤", message: "請檢查輸入完整", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "確定", style: .Destructive, handler: nil)
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func resultAlert(result: Bool) {
        let alert = UIAlertController(title: "新增狀態", message: result ? "成功" : "失敗", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "確定", style: result ? .Default : .Destructive) { (action) in
            if result {
                self.navigationController!.popViewControllerAnimated(true)
            }
        }
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func userInputisValid() -> Bool {
        var pass = true
        let userInput = [coverImageString, bookName.text, bookStore.text, bookURL.text, bookDescription.text, bookPhone.text]
        let _ = userInput.map({$0 == nil || $0 == "" ? pass = false : ()})
        return pass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverImage.layer.borderColor = UIColor.darkGrayColor().CGColor
        coverImage.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
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
