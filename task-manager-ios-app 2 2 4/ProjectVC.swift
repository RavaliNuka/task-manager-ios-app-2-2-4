//
//  ProjectVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/7/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class ProjectVC: UIViewController, UITextFieldDelegate {
    var project1 : AnyObject!

    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectDescription: UITextField!
    @IBOutlet weak var projectDeadline: UITextField!
    
    @IBOutlet weak var taskNames: UITextView!
    var textString:String!
    
    var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editSaveBTN(sender: AnyObject) {
        
        let pName=(project1["ProjectName"] as? String)!
        var url: NSString = "http://198.209.246.97/taskmanager/updateProject.php?OldProjectName=\(pName)&ProjectDescription=\(projectDescription.text!)&ProjectDeadline=\(projectDeadline.text!)&ProjectName=\(projectName.text!)&Email=\(sharedInfo.userEmail!)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func fetchTaskForProject()
    {
        let error:NSError?
        var  fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "projectName = %@", self.projectName.text!)

        let tasks:[Task] = (try! moc?.executeFetchRequest(fetchRequest)) as! [Task]
        
        
        if(tasks.count > 0)
        {
            self.taskNames.text = ""
            
            for task:Task in tasks
            {
                self.taskNames.text  = self.taskNames.text + task.taskName + " \n" + " \n"
            }
        }
        else {
            self.taskNames.text = "No tasks exists."
        }
        
    }
    
    var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!

    override func viewWillAppear(animated: Bool) {
//        let pName=(self.project1["ProjectName"] as? String)!
//        print("pName: \(pName)")
//        let url="http://198.209.246.97/taskmanager/tasksForProject.php?email=\(sharedInfo.userEmail!)&projectName=\(pName)"
//        print("tasks for project: \(url)")
//        let tasksforProject:NSArray = valuesReceived("http://198.209.246.97/taskmanager/tasksForProject.php?email=\(sharedInfo.userEmail!)&projectName=\(pName)")
//        
//        var textString=""
//        for(var i=0; i<tasksforProject.count;i++){
//            let tName=(tasksforProject[0]["TaskName"] as? String)!
//            textString += "\(tName) \n"
//        }
//        
       self.view.backgroundColor = sharedInfo.backGroundColor

        self.navigationItem.title = (self.project1["ProjectName"] as? String)!
        self.projectName.text = (self.project1["ProjectName"] as? String)!
        self.projectDescription.text = (self.project1["ProjectDescription"] as? String)!
        self.projectDeadline.text = (self.project1["ProjectDeadline"] as? String)!
        //retrieveTasks()
        taskNames.text=textString
       // self.taskNames.text=textString
       // fetchTaskForProject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func retrieveTasks(){
//        let pName=(self.project1["ProjectName"] as? String)!
//                print("pName: \(pName)")
//                let url="http://198.209.246.97/taskmanager/tasksForProject.php?email=\(sharedInfo.userEmail!)&projectName=\(pName)"
//                print("tasks for project: \(url)")
//                let tasksforProject:NSArray = valuesReceived("http://198.209.246.97/taskmanager/tasksForProject.php?email=\(sharedInfo.userEmail!)&projectName=\(pName)")
//        
//        
//                for(var i=0; i<tasksforProject.count;i++){
//                    let tName=(tasksforProject[0]["TaskName"] as? String)!
//                    textString += "\(tName) \n"
//                }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func valuesReceived(url: String)-> NSArray{
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        var error: NSError?
        var jsonArray: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
        
        if(jsonArray.count == 1){
            let key = (jsonArray[0]["TaskName"] as? String)!
            if(key=="----"){
                jsonArray = []
            }
        }
        
        return jsonArray
    }

}
