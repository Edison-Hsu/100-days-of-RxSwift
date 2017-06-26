//
//  ViewController.swift
//  SwiftIAd
//
//  Created by 徐 栋栋 on 4/2/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController,ADBannerViewDelegate {

    @IBOutlet weak var bannerView: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bannerView = ADBannerView(adType: .Banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        bannerView.isHidden = false
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        bannerView.isHidden = true
    }
}

