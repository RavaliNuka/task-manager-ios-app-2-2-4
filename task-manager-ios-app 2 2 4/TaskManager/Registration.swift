//
//  Registration.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/9/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Registration: NSObject {
  
    var firstName:String
    var lastName:String
    var emailID:String
    var password:String
    var confirmPassword:String
    var securityQuestion:String
    var answer:String
    
    init( Firstname:String, Lastname:String, emailid:String, Password:String, ConfirmPassword: String, SecurityQuestion:String, Answer:String) {
        self.firstName=Firstname
        self.lastName=Lastname
        self.emailID=emailid
        self.password=Password
        self.confirmPassword=ConfirmPassword
        self.securityQuestion=SecurityQuestion
        self.answer=Answer
    }
    
}
