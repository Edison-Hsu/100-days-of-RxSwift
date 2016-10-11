//
//  ViewController.swift
//  SaveDateLocationPhoto
//
//  Created by 徐 栋栋 on 08/10/2016.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Item {
//    private let image:UIImageView
//    private let date:NSDate
//    private let content:String
    let location:String
    
    init(location:String) {
//    init(image: UIImageView, date: NSDate, content: String, location: String) {
//        self.image = image
//        self.date = date
//        self.content = content
        self.location = location
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let items = Variable(Array<Item>())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.value = [
            Item(location: "123"),
            Item(location: "223")
        ]
//        let items = Observable.just([
//            "First Item",
//            "Second Item",
//            "Third Item"
//            ])
        
        items.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.location) @ row \(row)"
            }
            .addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

