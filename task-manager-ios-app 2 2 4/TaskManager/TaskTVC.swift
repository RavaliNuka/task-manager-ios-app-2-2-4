//
//  TaskTVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

import CoreData

class TaskTVC: UITableViewController {

    var tasks = [Task]()
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
    
    func setPriority()
    {
        let setting = NSEntityDescription.insertNewObjectForEntityForName("Setting", inManagedObjectContext: self.managedObjectContext!) as! Setting
        
        setting.priorityLimit = 10
        
        
        var error:NSError?
        
        do {
            try self.managedObjectContext?.save()
        } catch let error1 as NSError {
            error = error1
        }
        if(error != nil){
            print("problem in saving:\(error)")
        }
    }
    
    var setting: Setting!
    func fetchPriority()
    {
        let error:NSError?
        var settings:[Setting] = []
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Setting")
        
        
        settings = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Setting]
        
        if(settings.count > 0)
        {
            setting = settings[0]
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let userInfo=sharedInfo.valuesReceived("http://198.209.246.97/taskmanager/getUserSettings.php?email=\(sharedInfo.userEmail!)")
        
        sharedInfo.priorityLimit=(userInfo[0]["MaximumPriority"] as! NSString).integerValue
        sharedInfo.BGColor=(userInfo[0]["BGColor"] as? String)!
        
         sharedInfo.allTasks=valuesReceived("http://198.209.246.97/taskmanager/getAllTasks.php?email=\(sharedInfo.userEmail!)");
        sharedInfo.projectTasks=valuesReceived("http://198.209.246.97/taskmanager/projectTasks.php?email=\(sharedInfo.userEmail!)");
        
        
        sharedInfo.allProjects=valuesReceived1("http://198.209.246.97/taskmanager/getAllProjects.php?email=\(sharedInfo.userEmail!)");
        
        self.view.backgroundColor = sharedInfo.backGroundColor

        
        fetchPriority()
        
        if(setting == nil)
        {
            setPriority()
        }
        else
        {
            sharedInfo.priorityLimit = (setting.priorityLimit?.integerValue)!
        }
        dbActiveTasks = valuesReceived("http://198.209.246.97/taskmanager/activeTasks.php?email=\(sharedInfo.userEmail!)");
        //print("number of tasks in activelist: \(dbActiveTasks.count)")
        print("active tasks loaded")
    print("email value is: \(sharedInfo.userEmail!)")
        let url="http://198.209.246.97/taskmanager/todaysTasks.php?email=\(sharedInfo.userEmail!)"
        print("url value is: \(url)")
        dbTodaysTasks = valuesReceived(url);
        //print("number of tasks in todays list: \(dbTodaysTasks.count)")
        print("todays tasks loaded")
        
        dbCompletedTasks = valuesReceived("http://198.209.246.97/taskmanager/completedTasks.php?email=\(sharedInfo.userEmail!)");
        //print("number of tasks in completed list: \(dbCompletedTasks.count)")
        
        print("completed tasks loaded")
        loadContent()
        self.tableView.reloadData()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("in did select")
        sharedInfo.indexForTask=indexPath.row
    }
    
    
    
    
    var completedTasks = [Task]()
    var todaysTasks = [Task]()
    var activeTasks = [Task]()
    
    var dbCompletedTasks : NSArray=[]
    var dbTodaysTasks : NSArray=[]
    var dbActiveTasks : NSArray=[]
    
    var completed : Bool = false
    var active : Bool = false
    var today : Bool = true
    
    func fetchAllTasks()
    {
        var error:NSError?
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Task")
        
        tasks = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Task]
        
//        fetchTodayTasks()
//        fetchActiveTasks()
//        fetchCompletedTasks()
    }
    
    
    
    func hasDependentTask(var dependentTask:String, var taskType:String) -> Bool
    {
       
            let error:NSError?
            var  fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Task")
        
        
            let namePred = NSPredicate(format: "taskName = %@", dependentTask)
            let taskTypePred = NSPredicate(format: "taskType = %@", taskType)
        
            let compPred = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [namePred, taskTypePred])
            fetchRequest.predicate = compPred
            
            let tasks:[Task] = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Task]
            
            var isDep:Bool = false
        
            if(tasks.count > 0)
            {
                isDep = true
                
            }
        
        return isDep
       
    }
    
    func splitTasks()
    {
//        var error:NSError?
//        var fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Task")
//        fetchRequest.predicate = NSPredicate(format: " taskType = %@", "U")
//        
//        todaysTasks = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Task]
//        
        
        completedTasks = []
        todaysTasks    = []
        activeTasks    = []
        var todayDate:NSDate = NSDate()
        
    
//        for task:Task in tasks
//        {
//            if(task.taskType == "C")
//            {
//                completedTasks.append(task)
//            }
//            else
//            {
//                
//                if(findEqualDate(convertString2Date(task.deadline),withDate: todayDate))
//                {
//                    todaysTasks.append(task)
//                }
//                else
//                {
//                    activeTasks.append(task)
//                }
//                
//            }
//        }
        
    }
    
//    func fetchTasksFirst()
//    {
//        
//    }
//    
    
    
    func dateCompare(d_date:NSDate)->String
    {
        // Get current date
        let dateA = NSDate()
        
        // Get a later date (after a couple of milliseconds)
        let dateB = NSDate()
        
        var status:String = ""
        
        // Compare them
        switch dateA.compare(d_date) {
            
            case .OrderedSame          :   status = "T"
            
            default : status = "A"
        }
    
        return status
    }

    
    func findEqualDate(compareDate:NSDate, withDate:NSDate) -> Bool
    {
        var order = NSCalendar.currentCalendar().compareDate(withDate, toDate: compareDate,
            toUnitGranularity: .Day)
        var isSame:Bool = false
        
        switch order {
            case .OrderedDescending:
                isSame = false
            case .OrderedAscending:
                isSame = false
            case .OrderedSame:
                isSame = true
        }

        
        return isSame
    }
    
    func convertString2Date(strDate:String)-> NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        // dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        // dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let deadLineDate = dateFormatter.dateFromString(strDate)
        
        
        return deadLineDate!
        
    }
    
    func loadContent()
    {
        fetchAllTasks()
        tasks.sortInPlace({$0.deadline < $1.deadline})
        splitTasks()
        todaysTasks.sortInPlace({$0.deadline < $1.deadline})
        activeTasks.sortInPlace({$0.deadline < $1.deadline})
        completedTasks
            .sortInPlace({$0.deadline < $1.deadline})
        self.tableView.reloadData()
    }
    

    
    @IBAction func segmentedAction(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
               today = true
                active = false
            completed = false
               
        case 1:
                active = true
                today = false
                completed = false
                
        case 2:
               completed = true
               active = false
               today = false
            
        default:
            break
            
        }
        loadContent()
        
        //self.tableView.reloadData()
    }
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
//    override func viewDidAppear(animated: Bool) {
//        tasks.sort({$0.deadline < $1.deadline})
//        tableView.reloadData()
//        
//    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            
            // remove the deleted item from the model
            var error:NSError?
           
            
               managedObjectContext?.deleteObject(tasks[indexPath.row])
                do {
                    try managedObjectContext?.save()
                } catch let error1 as NSError {
                    error = error1
                }
                
            loadContent()
            
            
        default:
            return
        }
    }

    
    var count: Int = 0
    var newTask: Task!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
       // tasks.sort{$0.priority > $1.priority}
        self.tableView.reloadData()
        
        
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
//    override func viewWillAppear(animated: Bool) {
//       self.tableView.reloadData()
//        
//    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCnt:Int = 0
        allCells = []
        if(today)
        {
            if(dbTodaysTasks.count != 0){
                 rowCnt = dbTodaysTasks.count
            }else{
                rowCnt=0
            }
           
        }
        
        if(active)
        {
            if(dbActiveTasks.count != 0){
            rowCnt = dbActiveTasks.count
            }else{
                rowCnt=0
            }
            
        }
        
        if(completed)
        {
            if(dbCompletedTasks.count != 0){
            rowCnt = dbCompletedTasks.count
            }else{
                rowCnt=0
            }
        }
        
        
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return rowCnt
    }
    
    
   // override func viewDidAppear(animated: Bool) {
        
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDel.managedObjectContext!
//        
//        let fetchreq = NSFetchRequest(entityName: "Task")
//        let sortDescriptors = NSSortDescriptor(key: "priority", ascending: true)
//        fetchreq.sortDescriptors = [sortDescriptors]
        //  tasks = context.executeFetchRequest(fetchreq, error: nil)
        
        
   // }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TaskCustomCell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! TaskCustomCell
        
//        let priority=cell.viewWithTag(1) as! UILabel
//        let deadline=cell.viewWithTag(2) as!  UILabel
//        let taskName=cell.viewWithTag(3) as! UILabel
//        
        var abhi:AnyObject!
        
        
        if(today)
        {
            abhi = dbTodaysTasks[indexPath.row]
        }
        
       
        if(active)
        {
            abhi = dbActiveTasks[indexPath.row]
        }
        
        if(completed)
        {
            abhi = dbCompletedTasks[indexPath.row]
        }
        
    
        if(completed)
        {
            cell.statusBtn.hidden = true
        }
        else
        {
            cell.statusBtn.hidden = false
        }
        
        
        if(abhi.count != 0)
        {
            let prio=abhi["TaskPriority"] as? String
            let deadL=abhi["TaskDeadline"] as? String
            let tName=abhi["TaskName"] as? String
            cell.priorityLbl.text = prio!
            cell.deadLineLbl.text = deadL!
            cell.taskNameLbl.text = (tName?.capitalizedString)!
        }
        
        allCells.append(cell)
        cell.statusBtn.tag = indexPath.row
        cell.statusBtn.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        // Configure the cell...
     
        return cell
    }
    func buttonTapped(sender:UIButton) {
        print("in button tapped: \(sender.tag)")
        sharedInfo.indexForTask = sender.tag
    }
    var allCells:[TaskCustomCell] = []
    
    @IBAction func tableStatusBtnClicked(sender: AnyObject) {
    print("in button clicked function")
        print("index value in button tap: \(sender.tag)")
        var cnt:Int = 0
        //var cell:TaskCustomCell!

        for cell:TaskCustomCell in allCells{
            if(cell.selected){
                print("in selected")
                if(today){
                    print("in selected if")
                    
                    let tName=(dbTodaysTasks[sender.tag]["TName"] as? NSString)!
                    print("dependent task name: \(tName)")
                    let tStatus=(dbTodaysTasks[sender.tag]["TStatus"] as? NSString)!
                    print("dependent task status: \(tStatus)")
                    let ttName=(dbTodaysTasks[sender.tag]["TaskName"] as? String)!
                    print("ttname is: \(ttName)")
                    
                    if(tName.isEqualToString("Independent")){
                       
                        
                        print("in independent if")
                        cell.statusBtn.hidden=true
                        //let index=cell.indexOfAccessibilityElement(sender)
                        //let ttName=(dbTodaysTasks[index]["TaskName"] as? String)!
                        var alertController = UIAlertController(title: "Alert", message: "Are you sure the task is completed???", preferredStyle: .Alert)
                        
                        // Create the actions
                        var okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default) {
                            UIAlertAction in
                            NSLog("YES Pressed")
                            
                            
                            print("in status 1 condition")
                            //let index=cell.indexOfAccessibilityElement(sender)
                            var url: NSString = "http://198.209.246.97/taskmanager/updateTaskStatus.php?TaskName=\(ttName)&Email=\(self.sharedInfo.userEmail!)"
                            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                            var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                            var result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            
                            self.dbActiveTasks = self.valuesReceived("http://198.209.246.97/taskmanager/activeTasks.php?email=\(self.sharedInfo.userEmail!)");
                            //print("number of tasks in activelist: \(dbActiveTasks.count)")
                            print("active tasks loaded")
                            print("email value is: \(self.sharedInfo.userEmail!)")
                            let url2="http://198.209.246.97/taskmanager/todaysTasks.php?email=\(self.sharedInfo.userEmail!)"
                            print("url value is: \(url2)")
                            self.dbTodaysTasks = self.valuesReceived(url2);
                            //print("number of tasks in todays list: \(dbTodaysTasks.count)")
                            print("todays tasks loaded")
                            
                            self.dbCompletedTasks = self.valuesReceived("http://198.209.246.97/taskmanager/completedTasks.php?email=\(self.sharedInfo.userEmail!)");
                            //print("number of tasks in completed list: \(dbCompletedTasks.count)")
                            
                            self.loadContent()
                            self.tableView.reloadData()
                        }
                        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
                            UIAlertAction in
                            NSLog("No Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                    }
                        else if(tStatus=="1"){
                        
                        var alertController = UIAlertController(title: "Alert", message: "Are you sure the task is completed???", preferredStyle: .Alert)
                        
                        // Create the actions
                        var okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
                            UIAlertAction in
                            NSLog("Yes Pressed")
                            
                            
                            print("in status 1 condition")
                            //let index=cell.indexOfAccessibilityElement(sender)
                            var url: NSString = "http://198.209.246.97/taskmanager/updateTaskStatus.php?TaskName=\(ttName)&Email=\(self.sharedInfo.userEmail!)"
                            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                            var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                            var result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            
                            self.dbActiveTasks = self.valuesReceived("http://198.209.246.97/taskmanager/activeTasks.php?email=\(self.sharedInfo.userEmail!)");
                            //print("number of tasks in activelist: \(dbActiveTasks.count)")
                            print("active tasks loaded")
                            print("email value is: \(self.sharedInfo.userEmail!)")
                            let url2="http://198.209.246.97/taskmanager/todaysTasks.php?email=\(self.sharedInfo.userEmail!)"
                            print("url value is: \(url2)")
                            self.dbTodaysTasks = self.valuesReceived(url2);
                            //print("number of tasks in todays list: \(dbTodaysTasks.count)")
                            print("todays tasks loaded")
                            
                            self.dbCompletedTasks = self.valuesReceived("http://198.209.246.97/taskmanager/completedTasks.php?email=\(self.sharedInfo.userEmail!)");
                            //print("number of tasks in completed list: \(dbCompletedTasks.count)")
                            
                            self.loadContent()
                            self.tableView.reloadData()
                        }
                        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
                            UIAlertAction in
                            NSLog("No Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                        }
                }else{
                    
                        print("in selected if")
                        
                        let tName=(dbActiveTasks[sender.tag]["TName"] as? NSString)!
                        print("dependent task name: \(tName)")
                        let tStatus=(dbActiveTasks[sender.tag]["TStatus"] as? NSString)!
                        print("dependent task status: \(tStatus)")
                        let ttName=(dbActiveTasks[sender.tag]["TaskName"] as? String)!
                        print("ttname is: \(ttName)")
                        
                        if(tName.isEqualToString("Independent")){
                            
                            
                            print("in independent if")
                            cell.statusBtn.hidden=true
                            //let index=cell.indexOfAccessibilityElement(sender)
                            //let ttName=(dbTodaysTasks[index]["TaskName"] as? String)!
                            var alertController = UIAlertController(title: "Alert", message: "Are you sure the task is completed???", preferredStyle: .Alert)
                            
                            // Create the actions
                            var okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default) {
                                UIAlertAction in
                                NSLog("YES Pressed")
                                
                                
                                print("in status 1 condition")
                                //let index=cell.indexOfAccessibilityElement(sender)
                                var url: NSString = "http://198.209.246.97/taskmanager/updateTaskStatus.php?TaskName=\(ttName)&Email=\(self.sharedInfo.userEmail!)"
                                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                                url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                                var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                                var result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
                                
                                self.dbActiveTasks = self.valuesReceived("http://198.209.246.97/taskmanager/activeTasks.php?email=\(self.sharedInfo.userEmail!)");
                                //print("number of tasks in activelist: \(dbActiveTasks.count)")
                                print("active tasks loaded")
                                print("email value is: \(self.sharedInfo.userEmail!)")
                                let url2="http://198.209.246.97/taskmanager/todaysTasks.php?email=\(self.sharedInfo.userEmail!)"
                                print("url value is: \(url2)")
                                self.dbTodaysTasks = self.valuesReceived(url2);
                                //print("number of tasks in todays list: \(dbTodaysTasks.count)")
                                print("todays tasks loaded")
                                
                                self.dbCompletedTasks = self.valuesReceived("http://198.209.246.97/taskmanager/completedTasks.php?email=\(self.sharedInfo.userEmail!)");
                                //print("number of tasks in completed list: \(dbCompletedTasks.count)")
                                
                                self.loadContent()
                                self.tableView.reloadData()
                            }
                            var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
                                UIAlertAction in
                                NSLog("No Pressed")
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            alertController.addAction(cancelAction)
                            
                            // Present the controller
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                            
                        }
                        else if(tStatus=="1"){
                            
                            var alertController = UIAlertController(title: "Alert", message: "Are you sure the task is completed???", preferredStyle: .Alert)
                            
                            // Create the actions
                            var okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
                                UIAlertAction in
                                NSLog("Yes Pressed")
                                
                                
                                print("in status 1 condition")
                                //let index=cell.indexOfAccessibilityElement(sender)
                                var url: NSString = "http://198.209.246.97/taskmanager/updateTaskStatus.php?TaskName=\(ttName)&Email=\(self.sharedInfo.userEmail!)"
                                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                                url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
                                var data = NSData(contentsOfURL: NSURL(string: url as String)!)
                                var result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
                                
                                self.dbActiveTasks = self.valuesReceived("http://198.209.246.97/taskmanager/activeTasks.php?email=\(self.sharedInfo.userEmail!)");
                                //print("number of tasks in activelist: \(dbActiveTasks.count)")
                                print("active tasks loaded")
                                print("email value is: \(self.sharedInfo.userEmail!)")
                                let url2="http://198.209.246.97/taskmanager/todaysTasks.php?email=\(self.sharedInfo.userEmail!)"
                                print("url value is: \(url2)")
                                self.dbTodaysTasks = self.valuesReceived(url2);
                                //print("number of tasks in todays list: \(dbTodaysTasks.count)")
                                print("todays tasks loaded")
                                
                                self.dbCompletedTasks = self.valuesReceived("http://198.209.246.97/taskmanager/completedTasks.php?email=\(self.sharedInfo.userEmail!)");
                                //print("number of tasks in completed list: \(dbCompletedTasks.count)")
                                
                                self.loadContent()
                                self.tableView.reloadData()
                            }
                            var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
                                UIAlertAction in
                                NSLog("No Pressed")
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            alertController.addAction(cancelAction)
                            
                            // Present the controller
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                            
                        
                    }
                }
                    
                }
            }
        }
//        for cel:TaskCustomCell in allCells
//        {
//            if(cel.selected)
//            {
//                if(today)
//                {
//                    var tName=(dbTodaysTasks[cnt]["TName"] as? String)!
//                    if((tName.isEmpty) ||
//                        hasDependentTask(tName, taskType: "C"))
//                    {
//                        todaysTasks[cnt].taskType = "C"
//                        try! managedObjectContext?.save()
//                    }
//                    else
//                    {
//                        
//                        let myAlert = UIAlertController(title: "Alert", message: "Dependent on \(todaysTasks[cnt].dependentTask)", preferredStyle: UIAlertControllerStyle.Alert)
//                        
//                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//                        myAlert.addAction(okAction)
//                        self.presentViewController(myAlert, animated: true, completion: nil)
//                    }
//                }
//                
//                if(active)
//                {
//                    
//                    if((activeTasks[cnt].dependentTask.isEmpty) ||
//                        hasDependentTask(activeTasks[cnt].dependentTask, taskType: "C"))
//                    {
//                        activeTasks[cnt].taskType = "C"
//                        try! managedObjectContext?.save()
//                    }
//                    else
//                    {
//                        
//                        let myAlert = UIAlertController(title: "Alert", message: "Dependent on \(activeTasks[cnt].dependentTask)", preferredStyle: UIAlertControllerStyle.Alert)
//                        
//                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//                        myAlert.addAction(okAction)
//                        self.presentViewController(myAlert, animated: true, completion: nil)
//                    }
//                }
//            }
//            
//            cnt++
//        }
    
        
        //loadContent()
    //}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailTask"
        {
            let detailVC: TaskDVC = segue.destinationViewController as! TaskDVC
            let selectedRow = tableView.indexPathForSelectedRow!.row
            
            var selectedTask:AnyObject!
            if(completed)
            {
                selectedTask = self.dbCompletedTasks[selectedRow]
            }
            
            if(today)
            {
                selectedTask = self.dbTodaysTasks[selectedRow]
            }
            
            if(active)
            {
                selectedTask = self.dbActiveTasks[selectedRow]
            }
            
            
            //let selectedTask = self.tasks[selectedRow]
            if( selectedTask != nil)
            {
                detailVC.task1 = selectedTask
            }
            
        }
        
//        else if segue.identifier == "detailTask"
//        
//        {
//            var detailVC: TaskDVC = segue.destinationViewController as TaskDVC
//        }
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
    
    func valuesReceived1(url: String)-> NSArray{
        let data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
        
        if(jsonArray.count == 1){
            
            let key = (jsonArray[0]["ProjectName"] as? String)!
            if(key=="----"){
                jsonArray = []
            }
        }
        
        return jsonArray
    }
    
}
