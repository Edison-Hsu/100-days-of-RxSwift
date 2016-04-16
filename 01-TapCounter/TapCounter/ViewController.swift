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
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapButton.rx_tap
            .subscribeNext { [weak self] x in
                let number = Int((self?.numberLabel.text)!)
                self?.numberLabel.text = String(number!+1)
            }.addDisposableTo(disposeBag)
        
        resetButton.rx_tap
            .subscribeNext { [weak self] in
                self?.numberLabel.text = "0"
            }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

