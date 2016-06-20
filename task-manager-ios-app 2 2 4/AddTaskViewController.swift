//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by Nuka,Ravali on 10/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import EventKit
import CoreData
class AddTaskViewController: UIViewController, UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    let sharedInfo = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var priorityValues:[Int] = []

    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var taskDesc: UITextField!
    
    
    @IBOutlet weak var prereqTask: UITextField!
    
    @IBOutlet weak var belongingProject: UITextField!
    
    @IBOutlet weak var priority: UITextField!
    
    @IBOutlet weak var attachment: UITextField!
    @IBOutlet weak var taskDeadLine: UITextField!
    
    @IBAction func DatePickerButton(sender: UITextField) {
        print("in date picker")
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat="yyyy-MM-dd"
       taskDeadLine.text = dateFormatter.stringFromDate(sender.date)
        
        
        
        
    }

        
    
    

    
    
    @IBAction func CancelButton(sender: AnyObject) {
       // var mystory:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //var gov = mystory.instantiateViewControllerWithIdentifier("homeVC") as! HomeTVC
        //gov.gvc=self
        // println(navigationController)
        dismissViewControllerAnimated(true, completion: nil)
//        let homeVC:HomeTVC=HomeTVC()
//        
//        self.presentViewController(homeVC, animated: true, completion: nil)
        
        //performSegueWithIdentifier("CancelToHome", sender: nil)

    }
    
    
    @IBAction func addPrerequisteTask(sender: AnyObject) {
        var selectTask = self.storyboard?.instantiateViewControllerWithIdentifier("selectTask") as! SelectTaskTVC?
        selectTask?.atvc=self
        
        self.navigationController?.pushViewController(selectTask!, animated: true)
    }
    
    
    
    @IBAction func addProject(sender: AnyObject) {
        
        var selectProj = self.storyboard?.instantiateViewControllerWithIdentifier("selectProject") as! SelectedProjectTVC!
        selectProj.atvc=self
        
        self.navigationController?.pushViewController(selectProj!, animated: true)
    }
    
    
    
    @IBAction func SaveButton(sender: AnyObject) {
        print("inside save")
        
        if ((taskName.text!.isEmpty) || (taskDesc.text!.isEmpty) || ( taskDeadLine.text!.isEmpty) || (priority.text!.isEmpty))
        {
            if (taskName.text!.isEmpty){
                displayMyAlertMessage("Task name cannot be empty")
            }
            if(taskDesc.text!.isEmpty)
            {
                displayMyAlertMessage("Task description cannot be empty")
            }
            if(taskDeadLine.text!.isEmpty)
            {
                displayMyAlertMessage("Task deadline cannot be empty")
                
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
            if(prereqTask.text == ""){
                print("in prereq ifravali")
                prereqTask.text="Independent"
            }else{
                print("in prereq else")
                
            }
            if(belongingProject.text == ""){
                 belongingProject.text="Independent"
                print("in beloging if")
            }else{
                print("in belonging else")
               
            }
            sharedInfo.taskStatus="0"
            print("pre task val: \(prereqTask.text!)")
            print("belong project: \(belongingProject.text!)")
            print("email val: \(sharedInfo.userEmail!)")
            print("taskname: \(taskName.text!)")
            print("task desc: \(taskDesc.text!)")
            print("task deadline: \(taskDeadLine.text!)")
            print("priority: \(priority.text!)")
            print("status: \(sharedInfo.taskStatus!)")
            print("in else save")
            var count=0
            for(var i=0;i<sharedInfo.allTasks.count;i++){
                let name=(sharedInfo.allTasks[i]["TaskName"] as? NSString)!
                if(name.isEqualToString(taskName.text!)){
                    
                }else{
                    count++
                }
            }
            if(count==sharedInfo.allTasks.count){
                var url: NSString = "http://198.209.246.97/taskmanager/addTask.php?Email=\(sharedInfo.userEmail!)&TaskName=\(taskName.text!)&TaskDescription=\(taskDesc.text!)&TaskDeadline=\(taskDeadLine.text!)&TaskDependency=\(prereqTask.text!)&Projectid=\(belongingProject.text!)&TaskPriority=\(priority.text!)&Status=\(sharedInfo.status)";
                
                print("task url is: \(url)")
                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
                var myAlert = UIAlertController(title: "Alert", message: "Task added to the list", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
                    action in self.dismissViewControllerAnimated(true, completion: nil);
                    self.navigationController?.popToViewController(TaskTVC(), animated: true)
                }
                myAlert.addAction(okAction)
                self.presentViewController( myAlert, animated: true, completion: nil);
                
            }else{
                var myAlert = UIAlertController(title: "Alert", message: "Task already existed with same name", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
                    action in self.dismissViewControllerAnimated(true, completion: nil);
                    self.navigationController?.popToViewController(TaskTVC(), animated: true)
                }
                myAlert.addAction(okAction)
                self.presentViewController( myAlert, animated: true, completion: nil);
                
            }
            
            
            
            
            //adding to core data
            
            
            var assign = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: self.moc!) as! Task
            
            assign.taskName = self.taskName.text!
            assign.taskDesc = self.taskDesc.text!
            assign.deadline = self.taskDeadLine.text!
            //assign.dependentTask = self.belongingProject.text
            assign.priority = Int(self.priority.text!)!
            
            if(self.sharedInfo.isTaskSelected)
            {
                assign.dependentTask = self.sharedInfo.selectedTask.taskName
                self.sharedInfo.isTaskSelected = false
            }
            
            if(self.sharedInfo.isProjectSelected)
            {
                assign.projectName = (self.sharedInfo.selectedProject["projectName"] as? String)!
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
            
        }
    }
    
    
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    let alert = UIAlertView()
    
    
    
    
    var name: String = ""
    var desc: String = ""
    var deadline: String = ""
    var prereq: String = ""
    var proj: String = ""
    var prioritY: Int = 0
    
    @IBOutlet var priorityPicker: UIPickerView!
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func fillPriority()
    {
        priorityValues = []
        
        for(var i:Int = 1; i <= sharedInfo.priorityLimit; i++)
        {
            priorityValues.append(i)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = sharedInfo.backGroundColor

        
        fillPriority()
        
        priorityPicker = UIPickerView()
        priorityPicker.tag = 0
        priorityPicker.delegate = self
        priority.inputView = priorityPicker
        
        if(sharedInfo.isTaskSelected)
        {
            prereqTask.text = sharedInfo.selectedTask.taskName
            
            //sharedInfo.isTaskSelected = false
        }
        
        if(sharedInfo.isProjectSelected)
        {
            belongingProject.text = (sharedInfo.selectedProject["projectName"] as? String)!
            
            //sharedInfo.isProjectSelected = false
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
view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return sharedInfo.priorityLimit
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return "\(priorityValues[row])"
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        priority.text = "\(priorityValues[row])"
        // priorityTF.text = priorityOption[row]
        //  colorTF.text = colorOption[row]
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
