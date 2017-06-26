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
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
        
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = UISwipeGestureRecognizerDirection.down
        
        _ = gesture.rx.event.subscribe({
            [weak self] _ in
            guard let this = self else {
                return
            }
            this.view.endEditing(true)
        })
        
        view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

