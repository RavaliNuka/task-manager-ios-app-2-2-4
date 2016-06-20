//
//  RegistrationVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var confirmPassword: UITextField!
    var register: Registration!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var securityquestion: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailid: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    //@IBOutlet weak var Cancel: UIBarButtonItem!
   // @IBOutlet weak var Save: UIBarButtonItem!
    var array = [Registration]()
    
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
    
    @IBAction func saveUser(sender: AnyObject) {
        if ((!firstname.text!.isEmpty)||(!lastname.text!.isEmpty)||(!emailid.text!.isEmpty)||(!password.text!.isEmpty)||(!confirmPassword.text!.isEmpty)||(!securityquestion.text!.isEmpty)||(!answer.text!.isEmpty)){
            
            
            if(password.text!.isEqual(confirmPassword.text))
            {
                register = Registration(Firstname: firstname.text!, Lastname: lastname.text!, emailid: emailid.text!, Password: password.text!, ConfirmPassword: confirmPassword.text!, SecurityQuestion: securityquestion.text!, Answer: answer.text!)
                
                
                
            }
            else
            {
                displayMyAlertMessage("Passwords do not match.")
            }
            
        }
        else
        {
            displayMyAlertMessage("All fields are required.")
            
        }
        
        if ((!firstname.text!.isEmpty)&&(!lastname.text!.isEmpty)&&(!emailid.text!.isEmpty)&&(!password.text!.isEmpty)&&(!confirmPassword.text!.isEmpty)&&(!securityquestion.text!.isEmpty)&&(!answer.text!.isEmpty)&&(password.text!.isEqual(confirmPassword.text)))
        {
            print("in else condition")
            var url: NSString = "http://198.209.246.97/taskmanager/registration.php?emailID=\(emailid.text!)&LastName=\(lastname.text!)&FirstName=\(firstname.text!)&Password=\(password.text!)&Question=\(securityquestion.text!)&Answer=\(answer.text!)"
            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
            print("url value is: \(url)")
            var data = NSData(contentsOfURL: NSURL(string: url as String)!)
            var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            var registrationAlert = UIAlertView(title: "alert", message: "Please provide the values", delegate: nil, cancelButtonTitle: "OK")
            //            registrationAlert.show()
            //            performSegueWithIdentifier("redirectToLogin", sender: nil)
            
            
            
            
            
            var myAlert = UIAlertController(title: "Alert", message: "Registration is succesful! Thank you. ", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK ", style: UIAlertActionStyle.Default) {
                action in self.dismissViewControllerAnimated(true, completion: nil);
                self.navigationController?.popToRootViewControllerAnimated(true)
                
            }
            
            myAlert.addAction(okAction)
            self.presentViewController( myAlert, animated: true, completion: nil);
            
            
        }
        else
        {
            displayMyAlertMessage("All fields are required.")
            
            
        }
        
        
    }
    
    @IBAction func cancelRegistration(sender: AnyObject) {
        
        performSegueWithIdentifier("redirectToLogin", sender: nil)
    }
  
    
    let alert = UIAlertView()
    
   

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    
    }
}
    
