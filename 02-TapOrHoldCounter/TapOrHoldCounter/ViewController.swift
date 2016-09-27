//
//  ViewController.swift
//  TapOrHoldCounter
//
//  Created by 徐 栋栋 on 3/30/16.
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
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                let number = Int((self?.numberLabel.text)!)
                self?.numberLabel.text = String(number!+1)
            }).addDisposableTo(disposeBag)
        self.tapButton.addGestureRecognizer(longPressGesture)
        
        tapButton.rx.tap
            .subscribe(onNext: { [weak self] x in
                let number = Int((self?.numberLabel.text)!)
                self?.numberLabel.text = String(number!+1)
            }).addDisposableTo(disposeBag)
        
        resetButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.numberLabel.text = "0"
            }).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

