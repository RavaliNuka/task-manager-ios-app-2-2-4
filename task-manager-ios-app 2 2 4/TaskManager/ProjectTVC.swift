//
//  ProjectTVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData
class ProjectTVC: UITableViewController {

    
    var project = [Project]()
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

 
    var projectName: String!
    var projectDesc: String!
    var deadline:String!
    var projects:NSArray=[]
    
    @IBAction func cancel(segue:UIStoryboardSegue){
        
    }
    var sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!

    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = sharedInfo.backGroundColor

//        var error:NSError?
//        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Project")
//        
//        self.project = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Project]
////        project.sortInPlace({$0.projectDeadline < $1.projectDeadline})
////        tableView.reloadData()
//
//        tableView.reloadData()
//        print(self.project.count)
//        
        projects = valuesReceived("http://198.209.246.97/taskmanager/viewProjects.php?email=\(sharedInfo.userEmail)");
        print("number of projects in projects: \(projects.count)")
        tableView.reloadData()
    }
    
//    override func viewDidAppear(animated: Bool) {
//        project.sort({$0.projectDeadline < $1.projectDeadline})
//        tableView.reloadData()
//
//    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        switch editingStyle {
//        case .Delete:
//            // remove the deleted item from the model
//            var error:NSError?
//            var fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Project")
//            fetchRequest.predicate = NSPredicate(format: " projectName = %@  ", project[indexPath.row].projectName )
//            
//            project = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Project]
//            tableView.reloadData()
//            for item in project {
//                managedObjectContext?.deleteObject(item)
//                do {
//                    try managedObjectContext?.save()
//                } catch let error1 as NSError {
//                    error = error1
//                }
//                
//            }
//            
//            fetchRequest  = NSFetchRequest(entityName: "Project")
//            project = (try! managedObjectContext?.executeFetchRequest(fetchRequest)) as! [Project]
//            
//            tableView.reloadData()
//            
//        default:
//            return
//        }
//    }

   
    
    
    override func viewDidLoad() {
        tableView.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return projects.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) 
      let curProject=projects[indexPath.row]
        let projectname=cell.viewWithTag(1) as! UILabel
      //  var projectDescription=cell.viewWithTag(2) as UILabel
        let deadline=cell.viewWithTag(3)as! UILabel
      //  var scale=cell.viewWithTag(4) as! UILabel
        projectname.text = ((curProject["ProjectName"] as? String)?.capitalizedString)!
        deadline.text = curProject["ProjectDeadline"] as? String
        
      //  projectDescription.text = abhi.projectDesc
    //    scale.text = "\(abhi.scale)"
        // Configure the cell...

        return cell
    }
 

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
        if segue.identifier == "detailProject"
        {
            let detailVC: ProjectVC = segue.destinationViewController as! ProjectVC
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedProject = self.projects[selectedRow]
            detailVC.project1 = selectedProject
            let pName=(selectedProject["ProjectName"] as? String)!
            detailVC.textString=retrieveTasks(pName)
          //  if let destinationVC = segue.destinationViewController as? AddProjectVC{
                
            //}
        }
    }

    func valuesReceived(url: String)-> NSArray{
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
    func valuesReceived1(url: String)-> NSArray{
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

        
    func retrieveTasks(pName:String)->String{
        //let pName=(self.project1["ProjectName"] as? String)!
        //print("pName: \(pName)")
        var textString=""
        //let url="http://198.209.246.97/taskmanager/getAllTasks.php?email=\(sharedInfo.userEmail!)&projectName=\(pName)"
       // print("tasks for project: \(url)")
        //let tasksforProject:NSArray = valuesReceived1(url)
        
        
        for(var i=0; i<sharedInfo.projectTasks.count;i++){
            let proName=(sharedInfo.projectTasks[i]["ProjectName"] as? String)!
            let tName=(sharedInfo.projectTasks[i]["TaskName"] as? String)!
            if(proName == pName){
             textString += "\(i+1) \(tName) \n"
            }
            
        }
        return textString
    }
}
