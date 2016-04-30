//
//  APIManager.swift
//  ALPHACamp_finalExam
//
//  Created by Ka Ho on 29/4/2016.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import Foundation
import Firebase
import SystemConfiguration

let firebaseURL = ""
let firebseDBBookList = Firebase(url: firebaseURL + "/availableBooks")

// query book list from firebase DB
func getBookListFromFirebase(completion: (result: [BookDataInfo]) -> Void) {
    var returnBookList:[BookDataInfo] = []
    firebseDBBookList.queryOrderedByChild("timeStamp").observeEventType(.Value, withBlock: { (data) in
        for book in data.children {
            if let key = book.key, name = book.value["bookName"], image = book.value["coverImage"], url = book.value["bookURL"], store = book.value["bookStore"], description = book.value["bookDescription"], timeStamp = book.value["timeStamp"], phone = book.value["bookPhone"] {
                let eachBook = BookDataInfo()
                eachBook.bookID = String(key!)
                eachBook.bookName = String(name!)
                eachBook.coverImage = String(image!)
                eachBook.bookURL = String(url!)
                eachBook.bookStore = String(store!)
                eachBook.bookDescription = String(description!)
                eachBook.timeStamp = String(timeStamp!)
                eachBook.bookPhone = String(phone!)
                returnBookList.append(eachBook)
            }
        }
        completion(result: returnBookList)
    })
}

// add new book info
func addBookRequest(userinput:[String:String], completion: (result: Bool) ->  Void) {
    let insertBookRecords = firebseDBBookList.childByAutoId()
        insertBookRecords.setValue(userinput, withCompletionBlock: {
            (error:NSError?, ref:Firebase!) in
            completion(result: error == nil)
        })
}

// del book info
func delBookRequest(userinput:String, completion: (result: Bool) ->  Void) {
    let delBookRecords = firebseDBBookList.childByAppendingPath(userinput)
        delBookRecords.removeValueWithCompletionBlock { (error:NSError?, ref:Firebase!) in
            completion(result: error == nil)
        }
}
