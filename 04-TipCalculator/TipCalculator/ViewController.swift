//
//  ViewController.swift
//  TipCalculator
//
//  Created by 徐栋栋 on 4/4/16.
//  Copyright © 2016 edison. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    private let disposeBag = DisposeBag()
    
    let doneButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "Done"
        item.style = UIBarButtonItemStyle.Done
        return item
    }()

    var principal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.rx_tap
            .subscribeNext { [weak self] _ in
                if let numberTextLable = self!.numberTextField.text where !numberTextLable.isEmpty {
                    self!.principal = Double(numberTextLable)!.roundToPlaces(2)
                    self!.numberTextField.text = "$\(String(format: "%.2f", self!.principal))"
                    self!.calculator()
                }
            self!.view.endEditing(true)
            }.addDisposableTo(disposeBag)
        
        slider.rx_value
            .subscribeNext { [weak self] _ in
                self!.calculator()
        }.addDisposableTo(disposeBag)
        
        
        numberTextField.rx_controlEvent(.TouchDown)
            .subscribeNext { [weak self] _ in
                self!.numberTextField.text = ""
            }.addDisposableTo(disposeBag)
        

        let numberToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        numberToolbar.barStyle = UIBarStyle.Default
        numberToolbar.items = [doneButton]
        numberToolbar.sizeToFit()
        
        numberTextField.inputAccessoryView = numberToolbar
    }
    
    func calculator() {
        let percent = Double(slider.value).roundToPlaces(2)
        percentLabel.text = "(\(String(format: "%.0f", percent * 100))%)"
        tipLabel.text = "$\(String(format: "%.2f",principal * percent))"
        totalLabel.text = "$\(principal + Double(String(format: "%.2f",principal * percent))!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

