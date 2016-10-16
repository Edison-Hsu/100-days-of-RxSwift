//
//  ViewController.swift
//  SetLocation
//
//  Created by 徐 栋栋 on 16/10/2016.
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

func displayLocationInfo(placemark: CLPlacemark) -> String {
    let location = "\(placemark.thoroughfare ?? "") \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.country ?? "")"
    
    return location
}

class ViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    private let disposeBag = DisposeBag()
    let geolocationService = GeolocationService.instance
    let noGeolocationView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geolocationService.location
            .drive(locationLabel.rx.location)
            .addDisposableTo(disposeBag)
        
        geolocationService.authorized
            .drive(noGeolocationView.rx.driveAuthorization)
            .addDisposableTo(disposeBag)
            
        refreshButton.rx.tap
            .bindNext{ [weak self] in
                self?.geolocationService.requestAuthorization()
                self?.geolocationService.updateLocation()
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

