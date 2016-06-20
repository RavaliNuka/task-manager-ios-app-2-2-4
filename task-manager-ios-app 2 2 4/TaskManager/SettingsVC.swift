//
//  SettingsVC.swift
//  TaskManager
//
//  Created by Chintakindi,Gaurav Rammurthy on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

   
    let sharedInfo:AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var priorityTF: UITextField!
    
    @IBOutlet weak var colorTF: UITextField!
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    
  //  pickerView1.tag = 0
    
    
//    var colorArray = [Color(color: "Color1", R: 239.0, G: 28.0, B: 28.0),Color(color: "Color2", R: 155.0, G: 24.0, B: 24.0),Color(color: "Color3", R: 215.0, G: 144.0, B: 144.0),Color(color: "Color4", R: 129.0, G: 203.0, B: 134.0),Color(color: "Color5", R: 70.0, G: 178.0, B: 77.0),Color(color: "Color6", R: 215.0, G: 144.0, B: 144.0),Color(color: "Color7", R: 52.0, G: 213.0, B: 63.0),Color(color: "Color8", R: 30.0, G: 135.0, B: 37.0),Color(color: "Color9", R: 13.0, G: 239.0, B: 28.0),Color(color: "Color10", R: 13.0, G: 119.0, B: 239.0),Color(color: "Color11", R: 139.0, G: 170.0, B: 206.0),Color(color: "Color12", R: 174.0, G: 116.0, B: 203.0),Color(color: "Color13", R: 162.0, G: 58.0, B: 213.0),Color(color: "Color14", R: 255.0, G: 0.0, B: 255.0),Color(color: "Color15", R: 255.0, G: 102.0, B: 178.0),Color(color: "Color16", R: 0.0, G: 0.0, B: 0.0),Color(color: "Color17", R: 51.0, G: 51.0, B: 0.0),Color(color: "Color18", R: 0.0, G: 0.0, B: 255.0),Color(color: "Color19", R: 160.0, G: 160.0, B: 160.0),Color(color: "Color20", R: 102.0, G: 0.0, B: 0.0)]
    
    var colorDict = [String : Color]()
//
//        "a" : ["fname": "abc", "lname": "def"]
//        ,   "b" : ["fname": "ghi", "lname": "jkl"]
//        ,   ... : ...
//    ]
    
    @IBAction func logoutBTN(sender: UIButton) {
        
    
    }
    
    func fillColorDictionary()
    {
        colorDict.updateValue(Color(R: 209.0, G: 238.0, B: 238.0), forKey: "theme1")
        colorDict.updateValue(Color(R: 135.0, G: 206.0, B: 250.0), forKey: "theme2")
        colorDict.updateValue(Color(R: 255.0, G: 187.0, B: 255.0), forKey: "theme3")

    }
    
    @IBAction func saveBtnCliked(sender: AnyObject) {
    
        if(setting != nil)
        {
            setting.priorityLimit = sharedInfo.priorityLimit
            
            var error:NSError?
            
            do {
                try self.managedObjectContext?.save()
            } catch var error1 as NSError {
                error = error1
            }
            
        }
        if(priorityTF.text != "" && colorTF.text != ""){
       print("in not nill loop: prio:: \(priorityTF.text) :: col::\(colorTF.text)")
            var url: NSString = "http://198.209.246.97/taskmanager/updateUserSettings.php?Email=\(sharedInfo.userEmail!)&Priority=\(priorityTF.text!)&BGColor=\(colorTF.text!)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
        }else{
            print(" nill loop: prio:: \(priorityTF.text) :: col::\(colorTF.text)")
            if(priorityTF.text == ""){
                priorityTF.text=String(sharedInfo.priorityLimit)
                
            }
            if(colorTF.text == ""){
                colorTF.text=sharedInfo.BGColor!
            }
            
            var url: NSString = "http://198.209.246.97/taskmanager/updateUserSettings.php?Email=\(sharedInfo.userEmail!)&Priority=\(priorityTF.text!)&BGColor=\(colorTF.text!)"
            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
            let data = NSData(contentsOfURL: NSURL(string: url as String)!)
            let result1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
        }
        
        
        
        
        self.viewWillAppear(true)
    }
    
    func setPriority()
    {
        let setting = NSEntityDescription.insertNewObjectForEntityForName("Setting", inManagedObjectContext: self.managedObjectContext!) as! Setting
        
        setting.priorityLimit = 10
        
        
        var error:NSError?
        
        do {
            try self.managedObjectContext?.save()
        } catch var error1 as NSError {
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
    
    var priorityOption = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var colorOption:[String] =  [] //["Red", "Orange", "Yellow", "Blue", "Navy", "Pink", "Cyan", "Green"]
    
    func fillKeys()
    {
        colorOption = []
        
        for (key, _) in colorDict
        {
            colorOption.append(key)
        }
    }
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = sharedInfo.backGroundColor

        fillColorDictionary()
        fillKeys()
        
        fetchPriority()
        
        if(setting == nil)
        {
            setPriority()
        }
        else
        {
            priorityTF.text = "\(setting.priorityLimit!)"
            
            sharedInfo.priorityLimit = (setting.priorityLimit?.integerValue)!
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fillColorDictionary()
        fillKeys()
        pickerView1 = UIPickerView()
        pickerView1.tag = 0
        pickerView2 = UIPickerView()
        pickerView2.tag = 1
        pickerView1.delegate = self
        pickerView2.delegate = self
        priorityTF.inputView = pickerView1
        colorTF.inputView = pickerView2
colorTF.text=sharedInfo.BGColor
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return priorityOption.count
        } else if pickerView.tag == 1 {
            return colorOption.count
        }
        return 1
       // return priorityOption.count
       // return colorOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            return priorityOption[row]
        } else if pickerView.tag == 1 {
            return colorOption[row]
        }
        return ""
       // return priorityOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            priorityTF.text = priorityOption[row]
            sharedInfo.priorityLimit = row + 1
        }
        else if pickerView.tag == 1 {
            colorTF.text = colorOption[row]
            
            let col:Color = colorDict[colorTF.text!]!
            let red = (CGFloat) (col.R/255.0)
            let green = (CGFloat) (col.G/255.0)
            let blue = (CGFloat) (col.B/255.0)
            
            setting.red   = red
            setting.green = green
            setting.blue  = blue
            
            
            var error:NSError?
            
            do {
                try self.managedObjectContext?.save()
            } catch var error1 as NSError {
                error = error1
            }
            
            sharedInfo.backGroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
           // sharedInfo.backGroundColor = UIColor(red:col.R/255, green:col.G/255, blue:col.B/255, alpha:1.0)
        }

        
       // priorityTF.text = priorityOption[row]
      //  colorTF.text = colorOption[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
