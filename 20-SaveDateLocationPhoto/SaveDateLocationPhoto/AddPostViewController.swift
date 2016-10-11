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

private extension Reactive where Base: UILabel {
    var location: AnyObserver<CLLocation> {
        return UIBindingObserver(UIElement: base) { label, location in

            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                debugPrint(location)
                
                if error != nil {
                    debugPrint("Reverse geocoder failed with error" + (error!.localizedDescription))
                    return
                }
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    let pm = placemarks[0]
                    let street = displayLocationInfo(placemark: pm)
                    debugPrint(street)
                    label.text = street
                }
                else {
                    debugPrint("Problem with the data received from geocoder")
                }
            })
            
            }.asObserver()
    }
}

func displayLocationInfo(placemark: CLPlacemark) -> String {
    let location = "\(placemark.thoroughfare ?? "") \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.country ?? "")"

    return location
}

private extension Reactive where Base: UIView {
    var driveAuthorization: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { view, authorized in
            if authorized {
                view.isHidden = true
                view.superview?.sendSubview(toBack:view)
            }
            else {
                view.isHidden = false
                view.superview?.bringSubview(toFront:view)
            }
            }.asObserver()
    }
}

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
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
            UIBarButtonItem(customView: self.locationLabel),
            UIBarButtonItem(customView: self.imageView)
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
        let location = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 40))
        location.adjustsFontSizeToFitWidth = true
        location.textColor = UIColor.darkGray
        return location
    }()
    
    let geolocationService = GeolocationService.instance
    let noGeolocationView: UIView = {
        let view = UIView()
        return view
    }()
    
    weak var delegate: TableViewDelegate? = nil

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
        
        geolocationService.authorized
            .drive(noGeolocationView.rx.driveAuthorization)
            .addDisposableTo(disposeBag)
        
        geolocationService.location
            .drive(locationLabel.rx.location)
            .addDisposableTo(disposeBag)
        
        locationButton.rx.tap
            .bindNext { [weak self] in
                self?.geolocationService.updateLocation()
            }.addDisposableTo(disposeBag)
        
        cancelButton.rx.tap
            .bindNext { [weak self] in
                _ = self?.navigationController?.popViewController(animated: true)
            }.addDisposableTo(disposeBag)
        
        doneButton.rx.tap
            .bindNext { [weak self] in
                let currentDateTime = Date()
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .long
                
                let item = Item(image: (self?.imageView.image!)!,
                                date: formatter.string(from: currentDateTime),
                                content: (self?.textView.text!)!,
                                location: (self?.locationLabel.text!)!)
                self?.delegate?.addItem(item: item)
                _ = self?.navigationController?.popViewController(animated: true)
            }.addDisposableTo(disposeBag)
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
