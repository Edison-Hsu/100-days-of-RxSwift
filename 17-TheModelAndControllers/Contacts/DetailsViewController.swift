//
//  DetailsViewController.swift
//  Contacts
//
//  Created by 徐 栋栋 on 5/12/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var note: UILabel!
    
    var _name: String = ""
    var _avatar: String = ""
    var _mobile: String = ""
    var _email: String = ""
    var _note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        name.text = _name
        avatar.image = UIImage(named: _avatar)
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.layer.masksToBounds = true
        mobile.text = _mobile
        email.text = _email
        note.text = _note
        
        note.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        note.numberOfLines = 0

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
