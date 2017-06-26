//
//  ViewController.swift
//  TapCounter
//
//  Created by 徐 栋栋 on 3/27/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var numberLabel: UILabel!
    fileprivate let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapButton.rx.tap.subscribe({ [weak self] _ in
            guard let this = self else {
                return
            }
            guard let text = this.numberLabel.text else {
                return
            }
            guard let number = Int(text) else {
                return
            }
            this.numberLabel.text = String(number+1)
        }).addDisposableTo(disposeBag)
        
        resetButton.rx.tap.subscribe({ [weak self] _ in
            guard let this = self else {
                return
            }
            this.numberLabel.text = "0"
        }).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

