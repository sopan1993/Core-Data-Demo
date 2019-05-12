//
//  DisplayEmplyeeDetails.swift
//  CoreDataNewDemo
//
//  Created by Shirish Vispute on 19/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import CoreData

class DisplayEmplyeeDetails: UIViewController {

    @IBOutlet var pickerCompanyNames: UIPickerView!

    @IBOutlet var tableEmloyeeList: UITableView!
    
    var companyNames: [Company] = []
    
    var empArrForSelectedComp = [Employee]()
    
    var selectedCompany = Company()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchCompanies()
        // Do any additional setup after loading the view.
        self.tableEmloyeeList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func fetchCompanies(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Company")
        do {
            self.companyNames = try managedContext.fetch(fetchRequest) as! [Company]
            
            let request = NSFetchRequest<Employee>.init(entityName: "Employee")
            
            
            do{
                let resultArr = try! managedContext.fetch(request)
                self.empArrForSelectedComp = resultArr
                
                self.selectedCompany = self.companyNames[0]
                
                self.empArrForSelectedComp = self.selectedCompany.has?.allObjects as! [Employee]
                
                self.tableEmloyeeList.reloadData()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
}

extension DisplayEmplyeeDetails: UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.companyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerCompanyNames
        {
            let comp = self.companyNames[row]
            return comp.value(forKeyPath: "company_name") as? String
        }
        return "empty"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Employee>.init(entityName: "Employee")
        
        do{
             let resultArr = try! managedContext.fetch(request)
             self.empArrForSelectedComp = resultArr
            
             self.selectedCompany = self.companyNames[row]
            
             self.empArrForSelectedComp = self.selectedCompany.has?.allObjects as! [Employee]
            
            print( self.empArrForSelectedComp.count)
            
            self.tableEmloyeeList.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 40
    }
    
}

extension DisplayEmplyeeDetails: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableEmloyeeList
        {
            return self.empArrForSelectedComp.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableEmloyeeList
        {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let temp = self.empArrForSelectedComp[indexPath.row]
            cell.textLabel?.text = temp.employee_name
            cell.detailTextLabel?.text = String(temp.employee_id)
            return cell
        }
        else
        {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let temp = self.empArrForSelectedComp[indexPath.row]
            context.delete(temp)
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            self.empArrForSelectedComp.remove(at: indexPath.row)
            tableEmloyeeList.deleteRows(at: [indexPath], with: .fade)
            tableEmloyeeList.reloadData()
        }
        if editingStyle == .insert{
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
