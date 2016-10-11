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
    private let image:UIImage
    private let date:String
    private let content:String
    let location:String
    
    init(image: UIImage, date: String, content: String, location: String) {
        self.image = image
        self.date = date
        self.content = content
        self.location = location
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let items = Variable(Array<Item>())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

