//
//  ViewController.swift
//  AddPhotoFromCameraRoll
//
//  Created by 徐栋栋 on 4/14/16.
//  Copyright © 2016 edison. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barButtonItem.rx_tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx_createWithParent(self) { picker in
                    picker.sourceType = .PhotoLibrary
                    picker.allowsEditing = false
                }.flatMap {
                    $0.rx_didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }.subscribeNext { [weak self] image in
                let textAttachment = NSTextAttachment()
                let scaleFactor = (image?.size.width)! / (self!.textView.frame.size.width - 10);
                textAttachment.image = UIImage(CGImage: image!.CGImage!, scale: scaleFactor, orientation: .Up)
                let attString = NSAttributedString(attachment: textAttachment)
                self!.textView.textStorage.insertAttributedString(attString, atIndex: self!.textView.selectedRange.location)
            }.addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

