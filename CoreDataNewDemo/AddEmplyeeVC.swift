//
//  AddEmplyeeVC.swift
//  CoreDataNewDemo
//
//  Created by Shirish Vispute on 19/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import CoreData

class AddEmplyeeVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet var pickerCompanyNames: UIPickerView!
    @IBOutlet var txtfEmplyeeName: UITextField!
    @IBOutlet var txtfEmployeeId: UITextField!
    @IBOutlet var lblSeletedCompany: UILabel!
    
    var companyNames: [Company] = []
    static var selectedCompany = Company()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtfEmplyeeName.delegate = self
        txtfEmployeeId.delegate = self
    guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
    let managedContext =
            appDelegate.persistentContainer.viewContext
        
    let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Company")
        do {
            self.companyNames = try managedContext.fetch(fetchRequest) as! [Company]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtfEmplyeeName.resignFirstResponder()
        txtfEmployeeId.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return companyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerCompanyNames
        {
            let comp = companyNames[row]
            return comp.company_name
        }
       return "empty"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if companyNames.isEmpty
        {
            return
        }
        else
        {
            let comp = companyNames[row]
            self.lblSeletedCompany.text = comp.company_name
            AddEmplyeeVC.selectedCompany = comp
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    @IBAction func btnAddEmplyeeClicked(_ sender: Any) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
        let newEmployee = NSManagedObject(entity: entity!, insertInto: context) as! Employee

        newEmployee.employee_name = self.txtfEmplyeeName.text!
        newEmployee.employee_id = Int64(self.txtfEmployeeId.text!)!
        newEmployee.company_name = self.lblSeletedCompany.text!
        newEmployee.worksfor = AddEmplyeeVC.selectedCompany
        
        do {
            try context.save()
            self.txtfEmplyeeName.text = ""
            self.txtfEmployeeId.text = ""
        } catch {
            print("Failed saving")
        }
    }
    
}
