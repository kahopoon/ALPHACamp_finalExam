//
//  PhotoView_ViewController.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit

class PhotoView_ViewController: UIViewController {

    var imageString:String!
    @IBOutlet weak var coverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverImage.image = UIImage(data: NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions())!)
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
