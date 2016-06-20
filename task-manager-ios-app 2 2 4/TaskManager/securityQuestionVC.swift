//
//  securityQuestionVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class securityQuestionVC: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var securityQuestion: UITextField!
    var sharedInfo=UIApplication.sharedApplication().delegate as! AppDelegate
    var email:String!
    var userInfo:NSArray=[]
    @IBOutlet weak var answer: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
      userInfo=sharedInfo.valuesReceived("http://198.209.246.97/taskmanager/getUserSettings.php?email=\(email!)")
     securityQuestion.text = (userInfo[0]["Question"] as? String)!
        securityQuestion.enabled = false
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var ans:String=""
        if(answer.text!.isEmpty)
        {
           displayMyAlertMessage("Answer for the security question required!!!")
             ans = (userInfo[0]["Answer"] as? String)!
        }else if(answer.text! == ans){
       
            if segue.identifier == "confirmPassword"
            {
                
                let destinationVC = segue.destinationViewController as? newPasswordVC
                print("email from db: \(email!)")
                destinationVC?.email=email!
                print("email in new passvc: \(destinationVC?.email!)")
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

    
}