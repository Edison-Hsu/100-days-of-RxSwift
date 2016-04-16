//
//  SecondViewController.swift
//  PassingDataToAnotherView
//
//  Created by 徐栋栋 on 4/9/16.
//  Copyright © 2016 edison. All rights reserved.
//
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var receivedString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = receivedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

