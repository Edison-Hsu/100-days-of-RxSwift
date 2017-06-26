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
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barButtonItem.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                    }
                    .flatMap {
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
            }.map({
                info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }).subscribe(onNext: { [weak self] (image) in
                guard let this = self else {
                    return
                }
                guard let image = image else {
                    return
                }
                let textAttachment = NSTextAttachment()
                let scaleFactor = image.size.width / (this.textView.frame.size.width - 10);
                guard let cgImage = image.cgImage else {
                    return
                }
                textAttachment.image = UIImage(cgImage: cgImage, scale: scaleFactor, orientation: .up)
                let attString = NSAttributedString(attachment: textAttachment)
                this.textView.textStorage.insert(attString, at: this.textView.selectedRange.location)
            })
        .addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

