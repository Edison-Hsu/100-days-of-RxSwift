//
//  ViewController.swift
//  SettingTheDate
//
//  Created by 徐 栋栋 on 10/11/2016.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date;
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        button.rx.tap
            .bind { [weak self] in
                let selectedDate = dateFormatter.string(from: (self?.datePicker.date)!)
                self?.title = selectedDate
            }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

