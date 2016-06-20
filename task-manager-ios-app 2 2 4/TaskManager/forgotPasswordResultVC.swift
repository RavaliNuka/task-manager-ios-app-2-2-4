//
//  forgotPasswordResultVC.swift
//  TaskManager
//
//  Created by Sanakkayala,Abhinav Naidu on 7/12/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class forgotPasswordResultVC: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    Label1.text = "Your password is"
     label2.text = "TaskManager"
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
    }

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

}
