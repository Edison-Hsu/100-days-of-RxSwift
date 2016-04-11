//
//  ViewController.swift
//  SwipeToDismissKeyboard
//
//  Created by 徐栋栋 on 4/11/16.
//  Copyright © 2016 edison. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
        
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = UISwipeGestureRecognizerDirection.Down
        
        gesture.rx_event
            .subscribeNext { [weak self] _ in
                self?.view.endEditing(true)
        }.addDisposableTo(disposeBag)
        
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

