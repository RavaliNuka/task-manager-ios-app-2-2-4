//
//  newPasswordVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class newPasswordVC: UIViewController, UITextFieldDelegate {
    var email:String!
    var sharedInfo=UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        // Do any additional setup after loading the view.
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(newPassword.text!.isEmpty)
       {
        displayMyAlertMessage("New password required!!! ")
        }
        if(confirmPassword.text!.isEmpty)
        {
            displayMyAlertMessage("New password confirmation required!!!")
        }
        print("email: \(email) :: pass: \(newPassword.text) ")
        if(newPassword.text! == confirmPassword.text!){
            var url: NSString = "http://198.209.246.97/taskmanager/updatePassword.php?Email=\(sharedInfo.forEmail!)&password=\(newPassword.text!)"
            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
            print("url value is: \(url)")
            var data = NSData(contentsOfURL: NSURL(string: url as String)!)
            var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            var registrationAlert = UIAlertView(title: "alert", message: "Please provide the values", delegate: nil, cancelButtonTitle: "OK")
            //            registrationAlert.show()
            //            performSegueWithIdentifier("redirectToLogin", sender: nil)
            
            let alert = UIAlertView(title: "Alert", message: "Project added successfully.", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
            
             if segue.identifier == "login"
            {
                if let destinationVC = segue.destinationViewController as? LoginViewController{
                }
            }
            
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
    
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }

}