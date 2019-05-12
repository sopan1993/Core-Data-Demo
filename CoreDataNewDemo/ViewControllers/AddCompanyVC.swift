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

    func addCompany(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Company", in: managedContext)!
        let newEntity = NSManagedObject(entity: entity, insertInto: managedContext) as! Company
        newEntity.company_name = txtfCompanyName.text!
    
        do {
            try managedContext.save()
            self.txtfCompanyName.text = ""
        } catch {
            print("Failed saving")
        }
     
    }
    
    @IBAction func btnAddComanyClicked(_ sender: Any) {
        
        if txtfCompanyName.text == "" {
            AppUtility.showAlert(message: "Please enter company name.", vc: self, alertViewBackGrounColor: nil, textColor: nil)
        }else{
            addCompany()
        }
        
    
    }
    
  
}
