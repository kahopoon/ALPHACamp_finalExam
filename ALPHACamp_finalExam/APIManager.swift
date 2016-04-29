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
    if Reachability.isConnectedToNetwork() == true {
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
    } else {
        completion(result: [])
    }
}

// add new book info
func addBookRequest(userinput:[String:String], completion: (result: Bool) ->  Void) {
    if Reachability.isConnectedToNetwork() == true {
        let insertBookRecords = firebseDBBookList.childByAutoId()
        insertBookRecords.setValue(userinput, withCompletionBlock: {
            (error:NSError?, ref:Firebase!) in
            completion(result: error == nil)
        })
    } else {
        completion(result: false)
    }
}

// del book info
func delBookRequest(userinput:String, completion: (result: Bool) ->  Void) {
    if Reachability.isConnectedToNetwork() == true {
        let delBookRecords = firebseDBBookList.childByAppendingPath(userinput)
        delBookRecords.removeValueWithCompletionBlock { (error:NSError?, ref:Firebase!) in
            completion(result: error == nil)
        }
    } else {
        completion(result: false)
    }
}

// http://www.brianjcoleman.com/tutorial-check-for-internet-connection-in-swift/
// check internet status
// but seems not working... :p
public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
        
    }
}