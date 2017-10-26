//
//  ViewController.swift
//  iCloudStorageAssignment
//
//  Created by Sneha Kasetty Sudarshan on 10/5/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//
import Foundation
import UIKit
import CloudKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    var arrayRecord: Array<CKRecord> = []
    @IBOutlet weak var callsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callsTable.delegate = self
        callsTable.dataSource = self
        
        getdata()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let record: CKRecord = arrayRecord[(indexPath as IndexPath).row]
        
        let desc = record.value(forKey: "description")as? String
        let reason = record.value(forKey: "callReason")as? String
        let location = record.value(forKey: "location")as? String
        
        cell.textLabel?.text = reason! + ":" + location! + ":" + desc!
        return cell;
        
    }
    
    func getdata(){
        
        arrayRecord = Array<CKRecord>()
        let db = CKContainer.default().publicCloudDatabase
        let pred = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "iCloudCustomercall", predicate: pred)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        db.perform(query, inZoneWith: nil) {(results,error) in
            
            if error != nil {
                print("error" + error.debugDescription)
            }else{
                for result in results! {
                    self.arrayRecord.append(result)
                }
                OperationQueue.main.addOperation({ () -> Void in
                    self.callsTable.reloadData()
                    self.callsTable.isHidden = false
                    
                })
                
            }
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

