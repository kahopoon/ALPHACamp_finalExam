//
//  BookList_TableViewCell.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit

class BookList_TableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // book cover image appearance settings
        coverImage.layer.cornerRadius = 5
        coverImage.layer.borderWidth = 1
        coverImage.layer.borderColor = UIColor.grayColor().CGColor
        coverImage.layer.masksToBounds = true
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
