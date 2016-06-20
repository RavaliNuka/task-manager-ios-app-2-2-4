//
//  LoginViewController.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    var userCheck = 0
    var values : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        
        


        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBAction func loginAction(sender: AnyObject) {
        
            print("in login action method")
            if(emailTF.text!.isEmpty || passwordTF.text!.isEmpty){
            print("in login action method empty string condition")
                let alert = UIAlertView(title: "alert", message: "Please provide the values", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
            }
                
            else{
                print("in login action method else condition")
                values=appDel.valuesReceived("http://198.209.246.97/taskmanager/login.php");
                print("values in values: \(values.count)")
                for user in values{
                    let mailID = user["EmailID"] as! String
                    print("1")
                    print("USer MailID is: \(self.emailTF.text)")
                    let password = user["PASSWORD"] as! String
                    print("2")
                    print("YOur Password is: \(self.passwordTF.text)")
                    
                    if(self.emailTF.text == mailID && self.passwordTF.text == password){
                        appDel.userEmail = emailTF.text
                        print("3")
                        userCheck=1
                        appDel.userEmail=emailTF.text!
                        //validationCheck()
                    }
                    
                }
                
            }
        validationCheck()
        
        }
        
    @IBAction func registrationAction(sender: AnyObject) {
        performSegueWithIdentifier("loginToRegistration", sender: nil)
    }
    
        func validationCheck(){
            if(userCheck==1){
                performSegueWithIdentifier("login", sender: nil)
            }else{
                print("user check value in else condition: \(userCheck)")
                print("Condition failed")
                let alert = UIAlertView(title: "Insufficient Data", message: "UserID and passwords don't match", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
            }
        }
    
    @IBOutlet weak var login: UIButton!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ((segue.identifier == "login") && (login.selected))
        {
            if let destinationVC = segue.destinationViewController as? StartPageTBC{
                
            }
            else if ((segue.identifier == "forgot") && (forgotPassword.selected))
            {
                if let destinationVC = segue.destinationViewController as? forgotPasswordVC{
                    
                }
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
