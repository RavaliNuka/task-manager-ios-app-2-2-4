//
//  TaskCustomCell.swift
//  TaskManager
//
//  Created by sravya madarapu on 10/11/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit

class TaskCustomCell: UITableViewCell {

    
    
    @IBOutlet weak var priorityLbl: UILabel!
    
    @IBOutlet weak var deadLineLbl: UILabel!
    
    
    
    @IBOutlet weak var taskNameLbl: UILabel!
    
    @IBOutlet weak var statusBtn: UIButton!
    
    
  //  var isClicked:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    @IBAction func statusBtnClicked(sender: AnyObject) {
       //self.isClicked = true
       self.selected = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
