//
//  AddCompanyVC.swift
//  CoreDataNewDemo
//
//  Created by Shirish Vispute on 19/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import CoreData

class AddCompanyVC: UIViewController,UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var txtfCompanyName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtfCompanyName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtfCompanyName.resignFirstResponder()
        return true
    }

    @IBAction func btnAddComanyClicked(_ sender: Any) {
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(txtfCompanyName.text!, forKey: "company_name")
        
        do {
            try context.save()
            self.txtfCompanyName.text = ""
        } catch {
            print("Failed saving")
        }

    }
    
}
