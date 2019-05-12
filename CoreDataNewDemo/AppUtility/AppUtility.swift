//
//  AppUtility.swift
//  HatsOffDigitalTest
//
//  Created by Shirish Vispute on 11/05/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import Foundation
import UIKit

class Constant{
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
}
class AppUtility: NSObject{
    
    
   class func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
//    if isValidEmail("kirit@gmail.com"){
//    print("Validate EmailID")
//    }
//    else{
//    print("invalide EmailID")
//    }
    
    class func showAlert(message:String,vc:UIViewController,alertViewBackGrounColor:String?,textColor:String?){
        
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let subview1 = (actionSheetController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        
        actionSheetController.view.isUserInteractionEnabled = false
        
        switch alertViewBackGrounColor {
            
        case "red":
            subview1.backgroundColor = UIColor.red
        case "black":
            subview1.backgroundColor = UIColor.black
        case "green":
            subview1.backgroundColor = UIColor(red: (37/255.0), green: (165/255.0), blue: (145/255.0), alpha: 1.0)
        case "blue":
            subview1.backgroundColor = UIColor.blue
        default:
            break
        }
        
        switch textColor {
        case "white":
            actionSheetController.view.tintColor = UIColor.white
        case "green":
            actionSheetController.view.tintColor = UIColor(red: (37/255.0), green: (165/255.0), blue: (145/255.0), alpha: 1.0)
        case "black":
            actionSheetController.view.tintColor = UIColor.black
        case "red":
            actionSheetController.view.tintColor = UIColor.red
        default:
            break
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: message, style: .default) { action -> Void in }
        
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        vc.present(actionSheetController, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
