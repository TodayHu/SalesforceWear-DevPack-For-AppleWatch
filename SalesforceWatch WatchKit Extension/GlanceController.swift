//
//  GlanceController.swift
//  SalesforceWatch
//
//  Created by Quinton Wall on 3/4/15.
//  Copyright (c) 2015 Salesforce, Inc. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    
    @IBOutlet weak var headerImage: WKInterfaceImage!
    @IBOutlet weak var counterRing: WKInterfaceImage!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    var approvalsResult: NSArray!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        println("awake with context");
        
        // Configure interface objects here.
        counterRing.setImageNamed("glance-")
        
        
        
    }
    override func willActivate() {
        
        super.willActivate()
        self.getApprovalList()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //grab a list of pending approvals
    //use this to populate the correct approval chevrons
    private func getApprovalList() {
        let requestBundle = ["request-type" : "approval-count"]
        
        WKInterfaceController.openParentApplication(requestBundle, reply: { [unowned self](reply, error) -> Void in
            
            if let reply = reply as? [String: NSArray] {
                self.approvalsResult = reply["results"]
                var resultsCount = String(self.approvalsResult.count)
                self.titleLabel.setText(resultsCount+" Approvals")
                
                var cnt = self.approvalsResult.count as Int
                cnt = cnt * 10  //simple multiple to make the animation visible
                if ( cnt > 360 ) { cnt = 360 }
                
                self.counterRing.startAnimating()
                //repeat count of 0 = infinite looping
                self.counterRing.startAnimatingWithImagesInRange(NSMakeRange(0, cnt), duration: 1.0, repeatCount: 1)
                
            }
            else {
                // self.userNameLabel.setText("No Response")
                println("no response")
                
            }
        })
        
        
    }

}