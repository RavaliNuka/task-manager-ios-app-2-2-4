//
//  SelectTaskTVC.swift
//  TaskManager
//
//  Created by admin on 9/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class SelectTaskTVC: UITableViewController {
    var allTasks:NSArray=[]
   // var tasks = ["TaskA", "TaskB", "TaskC"]
    
    var tasks:[Task] = []
    var atvc:AddTaskViewController!
    
    var taskSelected:[Bool] = []
    
    let managedObjectContent = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let sharedInfo = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = sharedInfo.backGroundColor
        setNavBar()
       
        fetchTasks()
        firstSelected()
        allTasks=valuesReceived("http://198.209.246.97/taskmanager/viewTasks.php?Email=\(sharedInfo.userEmail)")
        
    }
    
    func firstSelected()
    {
        for(var i:Int = 0; i < tasks.count; i++)
        {
            if( i == 0)
            {
                taskSelected.append(true)
            }
            else
            {
                taskSelected.append(false)
            }
        }
    }
    
    
    func fetchTasks(){
        tasks = []
        
        let fetchRequest = NSFetchRequest(entityName: "Task")
        
        if let fetchResults = (try? managedObjectContent!.executeFetchRequest(fetchRequest)) as? [Task]
        {
            tasks = fetchResults
            
            
        }
    }
    
    
    
    func addBtnClicked(sender:UIBarButtonItem)
    {
        var cnt:Int = 0
        
        
//        for task in tasks
//        {
//            if(taskSelected[cnt])
//            {
//                
//                sharedInfo.isTaskSelected = true
//                sharedInfo.selectedTask = task
//                break
//                
//            }
//            
//            cnt++
//        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    func setNavBar()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addBtnClicked:")
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClicked:")
    }
//    
//    func cancelBtnClicked(sender: AnyObject) {
//        if((self.presentingViewController) != nil){
//            self.dismissViewControllerAnimated(true, completion: nil)
//            
//        }
//        
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         unSelectAll()
        let tempCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell?
        let listItem = allTasks[indexPath.row]
        let cell = tempCell!.textLabel as UILabel!
        cell.text = listItem["TaskName"] as! String
        tempCell!.backgroundColor = UIColor.clearColor()
        let tName=allTasks[indexPath.row]["TaskName"] as? String
        if (sharedInfo.dependentTask==tName)
        
        {
            tempCell!.accessoryType = UITableViewCellAccessoryType.Checkmark;
        }
        else
        {
            tempCell!.accessoryType = UITableViewCellAccessoryType.None;
        }
        
        return tempCell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        unSelectAll()
        
       // let tappedItem = tasks[indexPath.row]
        
       // taskSelected[indexPath.row] = !taskSelected[indexPath.row]
        sharedInfo.dependentTask=allTasks[indexPath.row]["TaskName"] as? String
        
        atvc.prereqTask.text=allTasks[indexPath.row]["TaskName"] as! String

      // tasks[indexPath.row] = tappedItem
        
        self.tableView.reloadData()
        //self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
  //  var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
    
//    override func viewWillAppear(animated: Bool) {
//        
//        self.view.backgroundColor = sharedInfo.backGroundColor
//    }
//    
    func unSelectAll()
    {
        taskSelected = []
        
        for(var i:Int = 0; i < tasks.count; i++)
        {
            taskSelected.append(false)
            
        }
    }
    
    func valuesReceived(url: String)-> NSArray{
        let data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
        
        if(jsonArray.count == 1){
            let key = (jsonArray[0]["TaskName"] as? String)!
            if(key=="----"){
                jsonArray = []
            }
        }
        
        return jsonArray
    }

}
