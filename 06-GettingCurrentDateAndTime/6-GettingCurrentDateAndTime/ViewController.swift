//
//  ViewController.swift
//  6-GettingCurrentDateAndTime
//
//  Created by 徐 栋栋 on 4/7/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshButton.rx.tap.map({
            x in
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.timeStyle = .medium
            return dateformatter.string(from: Date())
        }).bind(to: dateTimeLabel.rx.text).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

