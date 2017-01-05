//
//  ViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit

class SetUpPageViewController: UIViewController {
    
    
    @IBOutlet var header: UILabel!
   
    @IBOutlet var callToAction: UILabel!
    @IBOutlet var body: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setupTitle = "Your single guide to all TV entertainment"
        
        let setupBody = "To get the most out of your StreamSavvy app, we'll walk you through adding your favorites."
        
        let setupcallToAction = "You can add more at any time, but we'll start with one to show you how it works."

        header.text = setupTitle
        body.text = setupBody
        callToAction.text = setupcallToAction
        
        
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}

//MARK: UIPageViewControllerDataSource
