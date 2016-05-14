//
//  AddPostViewController.swift
//  TimelineExercises
//
//  Created by 徐 栋栋 on 5/14/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    lazy var toolbar: UIToolbar = {
       var bar = UIToolbar(frame: CGRectMake(0,0,self.view.frame.width, 44))
        bar.tintColor = UIColor.whiteColor()
        bar.translucent = false
        bar.clipsToBounds = true
        bar.items = [self.cameraButton, self.locationButton]
        return bar
    }()
    
    let cameraButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(named: "camera")!.imageWithRenderingMode(.AlwaysOriginal)
        btn.tintColor = UIColor.init(colorLiteralRed: 239/255, green: 249/255, blue: 246/255, alpha: 1.0)
        return btn
    }()
    
    let locationButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(named: "location")!.imageWithRenderingMode(.AlwaysOriginal)
//        btn.tintColor = UIColor.init(colorLiteralRed: 239/255, green: 249/255, blue: 246/255, alpha: 1.0)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.inputAccessoryView = toolbar
        
        // Do any additional setup after loading the view.
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
