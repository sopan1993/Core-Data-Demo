//
//  DisplayEmplyeeDetails.swift
//  CoreDataNewDemo
//
//  Created by Shirish Vispute on 19/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import CoreData

class DisplayEmplyeeDetails: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet var pickerCompanyNames: UIPickerView!

    @IBOutlet var tableEmloyeeList: UITableView!
    
    static var companyNames: [Company] = []
    static var empArrForSelectedComp = [Employee]()
    
    static var selectedCompany = Company()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableEmloyeeList.reloadData()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Company")
        do {
            DisplayEmplyeeDetails.companyNames = try managedContext.fetch(fetchRequest) as! [Company]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // Do any additional setup after loading the view.
        self.tableEmloyeeList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return DisplayEmplyeeDetails.companyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerCompanyNames
        {
            let comp = DisplayEmplyeeDetails.companyNames[row]
            return comp.value(forKeyPath: "company_name") as? String
        }
        return "empty"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let req = NSFetchRequest<Employee>.init(entityName: "Employee")
        let res = try! managedContext.fetch(req)
        DisplayEmplyeeDetails.empArrForSelectedComp = res
        
        DisplayEmplyeeDetails.selectedCompany = DisplayEmplyeeDetails.companyNames[row]
        
        DisplayEmplyeeDetails.empArrForSelectedComp = DisplayEmplyeeDetails.selectedCompany.has?.allObjects as! [Employee]
        
        print( DisplayEmplyeeDetails.empArrForSelectedComp.count)
        
        self.tableEmloyeeList.reloadData()
        
       
        }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 40
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableEmloyeeList
        {
            return DisplayEmplyeeDetails.empArrForSelectedComp.count
        }
        return 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableEmloyeeList
        {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let temp = DisplayEmplyeeDetails.empArrForSelectedComp[indexPath.row]
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
            let temp = DisplayEmplyeeDetails.empArrForSelectedComp[indexPath.row]
            context.delete(temp)
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            DisplayEmplyeeDetails.empArrForSelectedComp.remove(at: indexPath.row)
            tableEmloyeeList.deleteRows(at: [indexPath], with: .fade)
            tableEmloyeeList.reloadData()
        }
    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            let temp = DisplayEmplyeeDetails.empArrForSelectedComp[indexPath.row]
//            context.delete(temp)
//
//            do {
//                try context.save()
//            } catch {
//                print("Failed saving")
//            }
//        }
//
//       return [delete]
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
