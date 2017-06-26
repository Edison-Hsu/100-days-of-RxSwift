//
//  SecondViewController.swift
//  TableviewExercise
//
//  Created by 徐栋栋 on 4/29/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit

// protocol used for sending data back
protocol DataEnteredDelegate: class {
    func userDidEnterInformation(_ info: String)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    // making this a weak variable so that it won't create a strong reference cycle
    weak var delegate: DataEnteredDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func textOnExit(_ sender: AnyObject) {
        delegate?.userDidEnterInformation(textField.text!)
        self.navigationController?.popViewController(animated: true)
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
