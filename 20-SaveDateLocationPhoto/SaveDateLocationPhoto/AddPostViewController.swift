//
//  AddPostViewController.swift
//  TimelineExercises
//
//  Created by 徐 栋栋 on 5/14/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    fileprivate let disposeBag = DisposeBag()
    
    lazy var toolbar: UIToolbar = {
       var bar = UIToolbar(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: 44))
        bar.tintColor = UIColor.white
        bar.isTranslucent = false
        bar.clipsToBounds = true
        bar.items = [
            self.cameraButton,
            self.locationButton,
            UIBarButtonItem(customView: self.imageView),
            UIBarButtonItem(customView: self.locationLabel)
        ]
        return bar
    }()
    
    let cameraButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(named: "camera")!.withRenderingMode(.alwaysOriginal)
        btn.tintColor = UIColor.init(colorLiteralRed: 239/255, green: 249/255, blue: 246/255, alpha: 1.0)
        return btn
    }()
    
    let locationButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(named: "location")!.withRenderingMode(.alwaysOriginal)
        return btn
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let location = UILabel(frame: CGRect(x: 0,y: 0, width: 100, height: 40))
        return location
    }()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.inputAccessoryView = toolbar
        
        cameraButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerEditedImage] as? UIImage
            }
            .bindTo(imageView.rx.image)
            .addDisposableTo(disposeBag)
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
