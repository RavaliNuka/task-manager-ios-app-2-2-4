//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(str)


let d_date:NSDate = NSDate()


var dStr:String = "10/19/2015"


print(d_date)


func con(strDate:String) -> NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    let deadLineDate = dateFormatter.dateFromString(strDate)
    
    
    return deadLineDate!
}


//print(con(dStr).isEqualToDate(<#T##otherDate: NSDate##NSDate#>))




func dateComp(d_date:NSDate)
{
    // Get current date
    let dateA = NSDate()
    
    // Get a later date (after a couple of milliseconds)
    let dateB = NSDate()
    
    // Compare them
    switch dateA.compare(d_date) {
    case .OrderedAscending     :   print("Date A is earlier than date B")
    case .OrderedDescending    :   print("Date A is later than date B")
    case .OrderedSame          :   print("The two dates are the same")
    }

}


dateComp(con(dStr))



