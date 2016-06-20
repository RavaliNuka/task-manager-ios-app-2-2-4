//
//  AddTaskVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/8/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import EventKit
import CoreData
class AddTaskVC: UIViewController, UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {
//    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var prereqTask: UITextField!
    
    @IBOutlet weak var belongingProject: UITextField!
    
    @IBOutlet weak var priority: UITextField!
    let sharedInfo = UIApplication.sharedApplication().delegate as! AppDelegate
   
    //@IBOutlet weak var submit: UIBarButtonItem!
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var taskDesc: UITextField!
    var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBOutlet weak var taskDeadline: UITextField!
    
    
    
    
    func cancelBtnClicked(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
          
        }
       
    }
    
    
    
    @IBAction func addPreReqTaskBtn(sender: AnyObject) {
    
            var selectTask = self.storyboard?.instantiateViewControllerWithIdentifier("selectTask") as! UIViewController?
            
        self.navigationController?.pushViewController(selectTask!, animated: true)
        
    }
    
    
    @IBAction func addProjBtn(sender: AnyObject) {
        
        var selectProj = self.storyboard?.instantiateViewControllerWithIdentifier("selectProject") as! UIViewController?
        
        self.navigationController?.pushViewController(selectProj!, animated: true)
        
        
        
    }

    func setNavBar()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveBtnClicked:")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClicked:")
    }

    
    
    @IBAction func save(sender: AnyObject) {
       print("inside save")
            
            if ((taskName.text!.isEmpty) || (taskDesc.text!.isEmpty) || ( taskDeadline.text!.isEmpty) || (belongingProject.text!.isEmpty) || (priority.text!.isEmpty))
            {
                if (taskName.text!.isEmpty){
                    displayMyAlertMessage("Task name cannot be empty")
                }
                if(taskDesc.text!.isEmpty)
                {
                    displayMyAlertMessage("Task description cannot be empty")
                }
                if(taskDeadline.text!.isEmpty)
                {
                    displayMyAlertMessage("Task deadline cannot be empty")
                    
                }
                if(belongingProject.text!.isEmpty)
                {
                    displayMyAlertMessage("Project cannot be empty")
                }
                if(priority.text!.isEmpty)
                {
                    displayMyAlertMessage("Priority cannot be empty")
                }
                
                //displayMyAlertMessage("All fields are required!!!")
                return
            }
            else
            {
                print("in else save")
                var url: NSString = "http://198.209.246.97/taskmanager/addTask.php?Email=\(sharedInfo.userEmail)&TaskName=\(taskName.text)&TaskDescription=\(taskDesc.text)&TaskDeadline=\(taskDeadline.text)&TaskDependency=\(prereqTask.text)&Projectid=\(belongingProject.text)&TaskPriority=\(priority.text)&Status=\(sharedInfo.status)"
                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                
//                core data storage
                        var assign = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: self.moc!) as! Task
                
                       assign.taskName = self.taskName.text!
                       assign.taskDesc = self.taskDesc.text!
                        assign.deadline = self.taskDeadline.text!
                        //assign.dependentTask = self.belongingProject.text
                        assign.priority = Int(self.priority.text!)!
                
                        if(self.sharedInfo.isTaskSelected)
                        {
                            assign.dependentTask = self.sharedInfo.selectedTask.taskName
                            self.sharedInfo.isTaskSelected = false
                        }
                
                        if(self.sharedInfo.isProjectSelected)
                        {
                            assign.projectName = self.sharedInfo.selectedProject.projectName
                            self.sharedInfo.isProjectSelected = false
                        }
                
                
                        var error:NSError?
                
                        do {
                            try self.moc?.save()
                        } catch var error1 as NSError {
                            error = error1
                        }
                        if(error != nil){
                            print("problem in saving:\(error)")
                        }
                
                
                
                
                
                
                var myAlert = UIAlertController(title: "Alert", message: "Task added to the list", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
                    action in self.dismissViewControllerAnimated(true, completion: nil);
                    self.navigationController?.popToViewController(TaskTVC(), animated: true)
                    
                    
                    
                }
                
                
                
                myAlert.addAction(okAction)
                self.presentViewController( myAlert, animated: true, completion: nil);
                
            }
        }

    
    
//    func saveBtnClicked(sender: AnyObject) {
//        
//      if ((taskName.text.isEmpty) || (taskDesc.text.isEmpty) || ( taskDeadline.text.isEmpty) || (belongingProject.text.isEmpty) || (priority.text.isEmpty))
//      {
//        if (taskName.text.isEmpty){
//        displayMyAlertMessage("Task name cannot be empty")
//        }
//        if(taskDesc.text.isEmpty)
//        {
//            displayMyAlertMessage("Task description cannot be empty")
//        }
//        if(taskDeadline.text.isEmpty)
//        {
//            displayMyAlertMessage("Task deadline cannot be empty")
//            
//        }
//        if(belongingProject.text.isEmpty)
//        {
//            displayMyAlertMessage("Project cannot be empty")
//        }
//        if(priority.text.isEmpty)
//        {
//            displayMyAlertMessage("Priority cannot be empty")
//        }
//        
//        //displayMyAlertMessage("All fields are required!!!")
//       return
//        }
//        else
//      {
//        var url: NSString = "http://198.209.246.97/taskmanager/addTask.php?Email=\(appDel.userEmail)&TaskName=\(taskName.text)&TaskDescription=\(taskDesc.text)&TaskDeadline=\(taskDeadline.text)&TaskDependency=\(prereqTask.text)&Projectid=\(belongingProject.text)&TaskPriority=\(priority.text)&Status=\(appDel.status)"
//        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
//        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
//        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
//        var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
//    var myAlert = UIAlertController(title: "Alert", message: "Task added to the list", preferredStyle: UIAlertControllerStyle.Alert)
//    let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
//    action in self.dismissViewControllerAnimated(true, completion: nil);
//    self.navigationController?.popToViewController(TaskTVC(), animated: true)
//        
////        var assign = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: self.moc!) as! Task
////        
////       assign.taskName = self.taskName.text
////       assign.taskDesc = self.taskDesc.text
////        assign.deadline = self.taskDeadline.text
////        //assign.dependentTask = self.belongingProject.text
////        assign.priority = self.priority.text.toInt()!
////        
////        if(self.sharedInfo.isTaskSelected)
////        {
////            assign.dependentTask = self.sharedInfo.selectedTask.taskName
////            self.sharedInfo.isTaskSelected = false
////        }
////        
////        if(self.sharedInfo.isProjectSelected)
////        {
////            assign.projectName = self.sharedInfo.selectedProject.projectName
////            self.sharedInfo.isProjectSelected = false
////        }
////        
//        
////        var error:NSError?
////        
////        self.moc?.save(&error)
////        if(error != nil){
////            println("problem in saving:\(error)")
////        }
//
//     
//        }
//    
//    
//    
//        myAlert.addAction(okAction)
//        self.presentViewController( myAlert, animated: true, completion: nil);
//        
//            }
//    }
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    let alert = UIAlertView()
    


    @IBAction func dateEditing(sender: UITextField) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        taskDeadline.text = dateFormatter.stringFromDate(sender.date)
        
        
    }
 
    
    var name: String = ""
    var desc: String = ""
    var deadline: String = ""
    var prereq: String = ""
    var proj: String = ""
    var prioritY: Int = 0
    
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = sharedInfo.backGroundColor

        if(sharedInfo.isTaskSelected)
        {
          prereqTask.text = sharedInfo.selectedTask.taskName
            
            
        }
        
        if(sharedInfo.isProjectSelected)
        {
          belongingProject.text = sharedInfo.selectedTask.projectName
            
           // sharedInfo.isProjectSelected = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    }


