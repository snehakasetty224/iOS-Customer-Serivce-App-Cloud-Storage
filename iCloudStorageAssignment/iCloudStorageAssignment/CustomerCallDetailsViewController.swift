//
//  CustomerCallDetailsViewController.swift
//  iCloudStorageAssignment
//
//  Created by Sneha Kasetty Sudarshan on 10/5/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import UIKit
import CloudKit

class CustomerCallDetailsViewController: UIViewController {
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var callReason: UITextField!
    @IBOutlet weak var desc: UITextView!
    
    let database = CKContainer.default().publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonClick(_ sender: Any) {
        
        
        let recordstorage = CKRecord(recordType: "iCloudCustomerCall")
        recordstorage.setObject(location.text as CKRecordValue?, forKey: "location")
        
        recordstorage.setObject(desc.text as CKRecordValue?, forKey: "description")
        recordstorage.setObject(callReason.text as CKRecordValue?, forKey: "callReason")
        
        database.save(recordstorage) { (saveRecord, error) in
            if error != nil {
                print("error occured"  + (error?.localizedDescription)!)
            } else {
                print("Data save is successfull")
            
            }
        }
            
    }
    

}
