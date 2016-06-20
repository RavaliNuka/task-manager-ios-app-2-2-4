//
//  TaskDVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/7/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import EventKit
import CoreData
class TaskDVC: UIViewController, UITextFieldDelegate {

    var task1 : AnyObject!
    
    @IBOutlet weak var taskNameDetail: UITextField!
    
    @IBOutlet weak var taskDescDetail: UITextField!
    
    @IBOutlet weak var taskDeadlineDetail: UITextField!
    
    @IBOutlet weak var taskPrereqDetail: UITextField!
    
    @IBOutlet weak var taskProjectDetail: UITextField!
    
    @IBOutlet weak var taskpriorityDetail: UITextField!
    
    @IBOutlet weak var attachment: UITextField!
    var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var appDel=UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func editSaveBTN(sender: AnyObject) {
        let tName=(task1["TaskName"] as? String)!
        var url: NSString = "http://198.209.246.97/taskmanager/updateTask.php?OldTaskName=\(tName)&TaskDescription=\(taskDescDetail.text!)&TaskDeadline=\(taskDeadlineDetail.text!)&TaskName=\(taskNameDetail.text!)&Email=\(appDel.userEmail!)&TaskPriority=\(taskpriorityDetail.text!)&TaskDependency=\(taskPrereqDetail.text!)&ProjectName=\(taskProjectDetail.text!)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = sharedInfo.backGroundColor
       
        
        let name:String = (self.task1["TaskName"] as? String)!
        
        print("task name is: \(name)")
        self.navigationItem.title = name.capitalizedString
        self.taskNameDetail.text = ((self.task1["TaskName"] as? String)?.capitalizedString)!
        self.taskDescDetail.text = ((self.task1["TaskDescription"] as? String)?.capitalizedString)!
        self.taskDeadlineDetail.text = ((self.task1["TaskDeadline"] as? String)?.capitalizedString)!
        self.taskPrereqDetail.text = ((self.task1["TName"] as? String)?.capitalizedString)!
        self.taskpriorityDetail.text=(self.task1["TaskPriority"] as? String)!
        self.taskProjectDetail.text = ((self.task1["ProjectName"] as? String)?.capitalizedString)!
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "result"
//        {
//            if let destinationVC = segue.destinationViewController as? AddTaskVC{
//            }
//        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}