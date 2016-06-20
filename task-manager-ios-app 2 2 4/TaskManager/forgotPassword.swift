//
//  forgotPassword.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/9/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class forgotPassword: NSObject {
   
    var emailID:String
    var securityQuestion:String
    var answer:String
    
    init(emailid:String, securityquestion:String, Answer:String) {
        self.emailID=emailid
        self.securityQuestion=securityquestion
        self.answer=Answer
    }
    
    
}
