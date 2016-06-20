//
//  AddProjectVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/8/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddProjectVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectDesc: UITextField!
    @IBOutlet weak var projectDeadline: UITextField!
    var Scale = 4
    var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBAction func dateEditing(sender: UITextField) {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!

    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = sharedInfo.backGroundColor

    }
   
    func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat="yyyy-MM-dd"
        projectDeadline.text = dateFormatter.stringFromDate(sender.date)
   
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }
    
    
 
   
    
 
    
      
    @IBAction func save(sender: AnyObject) {
        if ((projectName.text!.isEmpty)||(projectDesc.text!.isEmpty)||(projectDeadline.text!.isEmpty))
        {
            
            
            if(projectName.text!.isEmpty)
            {
                displayMyAlertMessage("Project Name cannot be empty!!!")
            }
            if (projectDesc.text!.isEmpty)
            {
                displayMyAlertMessage("Project Description cannot be empty!!!")
            }
            if(projectDeadline.text!.isEmpty)
           {
               displayMyAlertMessage("Project Deadline cannot be empty!!!")
            }
            
        }
        else
        {
           
            var count=0
            for(var i=0;i<sharedInfo.allProjects.count;i++){
                let name=(sharedInfo.allProjects[i]["ProjectName"] as? NSString)!
                if(name.isEqualToString(projectName.text!)){
                    
                }else{
                    count++
                }
            }
            if(count==sharedInfo.allProjects.count){
                sharedInfo.status="1"
                var url: NSString = "http://198.209.246.97/taskmanager/addProject.php?ProjectName=\(projectName.text!)&ProjectDescription=\(projectDesc.text!)&ProjectDeadline=\(projectDeadline.text!)&Status=\(sharedInfo.status!)&Email=\(sharedInfo.userEmail!)"
                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                let data = NSData(contentsOfURL: NSURL(string: url as String)!)
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
//                var myAlert = UIAlertController(title: "Alert", message: "Project added to the list", preferredStyle: UIAlertControllerStyle.Alert)
//                let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
//                    action in self.dismissViewControllerAnimated(true, completion: nil);
//                    self.navigationController?.popToViewController(TaskTVC(), animated: true)
//                }
//                myAlert.addAction(okAction)
//                self.presentViewController( myAlert, animated: true, completion: nil);
//                
                let alert = UIAlertView(title: "Alert", message: "Project added successfully.", delegate: nil, cancelButtonTitle: "ok")
                alert.show()
                self.dismissViewControllerAnimated(true, completion: nil);
                
            }else{
//                var myAlert = UIAlertController(title: "Alert", message: "Project already existed with same name", preferredStyle: UIAlertControllerStyle.Alert)
//                let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
//                    action in self.dismissViewControllerAnimated(true, completion: nil);
//                    self.navigationController?.popToViewController(TaskTVC(), animated: true)
//                }
//                myAlert.addAction(okAction)
//                self.presentViewController( myAlert, animated: true, completion: nil);
                
                let alert = UIAlertView(title: "Alert", message: "Project with same name already exists.", delegate: nil, cancelButtonTitle: "ok")
                alert.show()
                self.dismissViewControllerAnimated(true, completion: nil);
                
                
            }
            
            
            
            
            
            
            
            

        }

    }
        
        override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
