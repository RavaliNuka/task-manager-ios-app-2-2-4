//
//  SelectedProjectTVC.swift
//  TaskManager
//
//  Created by admin on 9/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class SelectedProjectTVC: UITableViewController {
    
    //var projects = ["ProjectA", "ProjectB", "ProjectC", "ProjectD"]
    
    var projects:[Project] = []
    var atvc:AddTaskViewController!
    var selectedProject:[Bool] = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let sharedInfo = UIApplication.sharedApplication().delegate as! AppDelegate
    var allProjects:NSArray=[]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = sharedInfo.backGroundColor

        setNavBar()
        fetchProjects()
        firstSelected()
        allProjects = valuesReceived("http://198.209.246.97/taskmanager/viewProjects.php?email=\(sharedInfo.userEmail)");
        print("number of projects in projects: \(projects.count)")
        
    }
    
    
    func fetchProjects(){
        projects = []
        
        let fetchRequest = NSFetchRequest(entityName: "Project")
        
        if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [Project]
        {
            projects = fetchResults
            
            
        }
    }

    
    
    func firstSelected() {
        for(var i:Int = 0; i < allProjects.count; i++)
        {
            if(i == 0)
            {
                selectedProject.append(true)
            }
            else
            {
                selectedProject.append(false)
            }
        }
    }
    
    func addBtnClicked(sender: UIBarButtonItem)
    {
        var cnt: Int = 0
//        for project in allProjects
//        {
//            if(selectedProject[cnt])
//            {
//                sharedInfo.selectedProject = project
//                sharedInfo.isProjectSelected = true
//                break
//            }
//            cnt++
//        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setNavBar()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addBtnClicked:")
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClicked:")
    }
    
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.allProjects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         unSelectAll()
        let tempCell = tableView.dequeueReusableCellWithIdentifier("projectCell") as! UITableViewCell?
        let listItem = allProjects[indexPath.row]
        let cell = tempCell!.textLabel as UILabel!
        cell.text = listItem["ProjectName"] as? String
        tempCell!.backgroundColor = UIColor.clearColor()
        let pName=allProjects[indexPath.row]["ProjectName"] as? String
        if (sharedInfo.dependentProject==pName)
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
        
        //selectedProject[indexPath.row] = !selectedProject[indexPath.row]
        
        sharedInfo.dependentProject=allProjects[indexPath.row]["ProjectName"] as? String
        
        atvc.belongingProject.text=allProjects[indexPath.row]["ProjectName"] as! String
        self.tableView.reloadData()
    }
    
    func unSelectAll()
    {
        selectedProject = []
        
        for(var i:Int = 0; i < projects.count; i++)
        {
            selectedProject.append(false)
            
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
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


}
