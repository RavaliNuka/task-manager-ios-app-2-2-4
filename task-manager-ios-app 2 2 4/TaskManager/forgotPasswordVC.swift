//
//  forgotPasswordVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/9/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class forgotPasswordVC: UIViewController, UITextFieldDelegate {
var sharedInfo=UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var emailID: UITextField!
           override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(emailID.text!.isEmpty)
       {
        displayMyAlertMessage("EmailID Required!!!")
        }
        else if  segue.identifier == "result"
        {
              let destinationVC = segue.destinationViewController as? securityQuestionVC
            destinationVC?.email=emailID.text!
            sharedInfo.forEmail=emailID.text!
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
 
}