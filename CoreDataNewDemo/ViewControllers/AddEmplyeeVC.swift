//
//  AddEmplyeeVC.swift
//  CoreDataNewDemo
//
//  Created by Shirish Vispute on 19/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import CoreData

class AddEmplyeeVC: UIViewController,UITextFieldDelegate {

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
        fetchRecord()
   
        // Do any additional setup after loading the view.
    }
    
    func fetchRecord()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Company")
        
        do {
            self.companyNames = try managedContext.fetch(fetchRequest) as! [Company]
            self.lblSeletedCompany.text = self.companyNames[0].company_name!
            AddEmplyeeVC.selectedCompany = self.companyNames[0]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        txtfEmplyeeName.resignFirstResponder()
        txtfEmployeeId.resignFirstResponder()
        return true
    }
    
    func addEmpRecord(){
        
            
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)!
        let newEmployee = NSManagedObject(entity: entity, insertInto: context) as! Employee
        
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
    
    @IBAction func btnAddEmplyeeClicked(_ sender: Any) {
        
        if txtfEmplyeeName.text == "" {
            AppUtility.showAlert(message: "Please enter employee name.", vc: self, alertViewBackGrounColor: nil, textColor: nil)
        } else if txtfEmployeeId.text == "" {
            AppUtility.showAlert(message: "Please enter employee id.", vc: self, alertViewBackGrounColor: nil, textColor: nil)
        } else {
            
            addEmpRecord()
        }
    }
    
}

extension AddEmplyeeVC: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return companyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerCompanyNames
        {
            
            return companyNames[row].company_name
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
}

